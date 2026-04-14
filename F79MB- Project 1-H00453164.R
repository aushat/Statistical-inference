# Project 1 --- H00453164 -- Fathima Aushat Azaar

# Question 1

# Q1a
# Load the data
bug_time = scan("C:/HWU/Year 3/SEM 2/Stats Model B/cw1/bug_time.txt") ; bug_time  

# Histogram and boxplot to visualize the data
hist(bug_time, main = "Histogram of Bug Resolution Times", 
     xlab = "Resolution Time (mins)", 
     ylab = "Frequency (No. of Bugs)",col = "pink")  

boxplot(bug_time, main = "Boxplot of Bug Resolution Times",
        xlab = "Resolution Time (mins)",
        col = "lightgreen", horizontal = TRUE) 

# Numerical summaries for the data
summary(bug_time)  
sd(bug_time)       # sample standard deviation
var(bug_time)      # sample variance

# Q1b(ii)

log_bug = log(bug_time)  # log-transform of the data

# MLE of mu 
mu_hat = sum(log_bug)/length(log_bug)

# Sample mean
sample_mean = mean(log_bug) ; mu_hat  

# MLE of var 
n = length(log_bug); n  # sample size
sigma2_hat = sum((log_bug - mu_hat)^2) / n ; sigma2_hat  

# Sample variance
sample_var = var(log_bug) ; sample_var  # R variance uses /(n-1)


# Q1c

# Q-Q plot against Normal
qqnorm(log_bug, main = "Normal Q–Q Plot of log of bug times", col = "blue")  # to check normality of log-data
qqline(log_bug, col = "red")  # reference line of the normal distribution


# Q1d


# Chi-square goodness of fit test 

ncell = 10 # 10 cells

# Estimate parameters from log-data
mu_hat = mean(log_bug)   # mean
sigma2_hat = sum((log_bug - mu_hat)^2) / n  # variance
sigma_hat = sqrt(sigma2_hat)     # standard dev    

# 10 equal-probability cells under fitted lognormal
probs = seq(0, 1, length.out = 11)

bug.breaks = qlnorm(probs, mu_hat, sigma_hat) ; bug.breaks  # quantile break points 

# Observed frequencies 
bug.cut = cut(bug_time, breaks = bug.breaks, include.lowest = TRUE, right = TRUE)  # assigning each obs to a bin
bug.table = table(bug.cut) ; bug.table  # observed counts per bin

# Expected frequencies using plnorm 
prob = numeric(ncell)  
exp.f = numeric(ncell) 

for(i in 1:ncell){
  prob[i] = plnorm(bug.breaks[i+1], meanlog = mu_hat, sdlog = sigma_hat) -
    plnorm(bug.breaks[i],   meanlog = mu_hat, sdlog = sigma_hat)  # P(bin i)
  exp.f[i] = prob[i] * n  # expected frequency in bin i
}
exp.f  # = 20 each

# Extract observed frequencies 
obs.f = numeric(ncell)
for(i in 1:ncell) obs.f[i] = bug.table[[i]]  # convert table to numeric vector
obs.f

# Chi-square statistic
X2 = sum((obs.f - exp.f)^2 / exp.f) ; X2  # chi-square statistic

# df = (n0. of cells - 1 - no. of estimated parameters)
df = ncell - 1 - 2 ; df  # subtract 2 for estimating mu and sigma^2

# p-value
pval = 1 - pchisq(X2, df) ; pval  # right-tail p-value

# Table with intervals and observed freq
Table = data.frame(
  Interval = names(bug.table),      # interval labels
  Observed = obs.f,                 # observed counts
  Expected = round(exp.f)        # expected counts
)
Table


# Question 2

# Q2a

# Load the data
app_dur = scan("C:/HWU/Year 3/SEM 2/Stats Model B/cw1/app_session_duration.txt")
n = length(app_dur) ; n 

# Histogram and boxplot to visualize the data
hist(app_dur, main = "Histogram of App Session Durations", 
     xlab = "Session duration (mins)", 
     ylab = "Frequency (No. of sessions)",col = "lavender")  

boxplot(app_dur, main = "Boxplot of App Session Durations",
        xlab = "Session duration (mins)",
        col = "lightblue", horizontal = TRUE) 

# Numerical summaries for the data
summary(app_dur)  
sd(app_dur)       # sample standard deviation
var(app_dur)      # sample variance


# Q2b

B = 10000          # no. of bootstrap resamples
n = length(app_dur)

median.b = numeric(B) # puts empty values so u have space

for(i in 1:B){
  median.b[i] = median(sample(app_dur, size = n, replace = TRUE))  # bootstrap median
}

summary(median.b)  # numerical summaries of bootstrap medians

# The bootstrap distribution plots
# Histogram and boxplots 
hist(median.b,
     main = "Histogram of Bootstrap Dist. of the Median",
     xlab = "Bootstrap Median", col = "orange")  # this is the empirical sampling distribution

boxplot(median.b, horizontal = TRUE,
        main = "Boxplot of Bootstrap Medians",
        xlab = "Bootstrap Median", col = "red")  

# 95% percentile CI for bootstrap
CI = quantile(median.b, c(0.025, 0.975)) ; CI 


# Q2c
# median asymptotic CI

log_app = log(app_dur) # log of data
n = length(log_app)

m_hat = median(log_app) ; m_hat          # sample median on log-scale
sigma_hat = sd(log_app) ; sigma_hat      # estimate of sigma on log-scale

f_m = 1 / (sigma_hat * sqrt(2*pi))      # since median = mean for Normal

SE_m = 1 / (2 * f_m * sqrt(n)) ; SE_m   # Standard error using general asymptotic formula

# 95% CI for m hat
lower_m = m_hat - 1.96 * SE_m
upper_m = m_hat + 1.96 * SE_m
c(lower_m, upper_m)

# Asymptotic 95% CI for median
CI_median = exp(c(lower_m, upper_m)) ; CI_median 


# Q2d

IQR.b = numeric(B)  # storing bootstrap IQRs as empty spaces for now

for(i in 1:B){
  IQR.b[i] = IQR(sample(app_dur, size = n, replace = TRUE))  # bootstrap IQR
}

# 95% percentile CI
CI_IQR = quantile(IQR.b, probs = c(0.025, 0.975)) ; CI_IQR


# Q2e

obs_median = median(app_dur) ; obs_median  # observed median which is the test statistic

mu0 = log(15)  # null value for mu

sigma_hat = sd(log(app_dur))  # use estimated sigma from Q2c

median.b.par = numeric(B)  # storing parametric bootstrap medians as empty spaces for now

for(i in 1:B){
  median.b.par[i] = median(rlnorm(n, meanlog = mu0, sdlog = sigma_hat))  # simulate under H0
}

p_value = mean(median.b.par >= obs_median) ; p_value  # one-sided p-value for the right tail

# Histogram of parametric bootstrap medians
hist(median.b.par,
     main = "Histogram of Parametric Bootstrap Dist. of Median",
     xlab = "Bootstrap Median",
     col = "lightyellow")  

# Vertical line for observed median
abline(v = obs_median, col = "red", lwd = 2)  # observed test statistic

legend("topright",legend = c("Observed median"),
       col = c("red"), lty =1)  # legend for the red line
