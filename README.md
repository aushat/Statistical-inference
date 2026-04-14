# Statistical Inference in R

This project applies statistical inference techniques in R to analyse two datasets: bug resolution times and app session durations.

The work combines exploratory data analysis, lognormal modelling, maximum likelihood estimation, goodness-of-fit testing, bootstrap confidence intervals, and parametric bootstrap hypothesis testing.

## Project objectives

- Explore the distribution of bug resolution times and app session durations
- Fit a lognormal model where appropriate
- Estimate model parameters using maximum likelihood estimation (MLE)
- Assess model fit using graphical and formal methods
- Use bootstrap methods to estimate confidence intervals
- Carry out a parametric bootstrap hypothesis test for the population median

## Files in this repository

- `statistical_inference_project.R` — R code
- `bug_time.txt` — bug resolution time dataset
- `app_session_duration.txt` — app session duration dataset
- `report.pdf` — full written report on this project

## Methods used

- Histograms and boxplots
- Numerical summaries
- Log transformation
- Maximum likelihood estimation (MLE)
- Normal Q-Q plot
- Chi-square goodness-of-fit test
- Non-parametric bootstrap
- Asymptotic confidence interval
- Parametric bootstrap hypothesis test

## Main tasks

### 1. Bug resolution times
- Explored the distribution using summary statistics and plots
- Applied a log transformation due to positive skewness
- Estimated the parameters of the lognormal model
- Assessed normality of the log-transformed data using a Q-Q plot
- Performed a chi-square goodness-of-fit test for the fitted lognormal model

### 2. App session durations
- Explored the distribution using summary statistics and plots
- Used a non-parametric bootstrap to estimate the sampling distribution of the median
- Constructed a bootstrap confidence interval for the median
- Constructed an asymptotic confidence interval for the median under a lognormal model
- Estimated a bootstrap confidence interval for the IQR
- Carried out a parametric bootstrap hypothesis test to assess whether the population median exceeds 15 minutes

## Key results

- Bug resolution times showed strong positive skewness, so a lognormal model was appropriate
- The log-transformed bug times were approximately normal
- The chi-square goodness-of-fit test did not show evidence against the fitted lognormal model
- Bootstrap methods gave a practical way to estimate uncertainty for the app session data
- The parametric bootstrap test did not provide strong evidence that the population median app session duration exceeds 15 minutes


## Tools used

- R
- Base R functions for simulation, plotting, and inference

## Skills demonstrated

- Statistical modelling
- Data analysis in R
- Distribution fitting
- Bootstrap resampling
- Hypothesis testing
- Interpretation of statistical results
