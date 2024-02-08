---
title: "Introduction to forecasting"
output:
  html_document: default
layout: post
mathjax: true
---

### The goal ###

For this exercise, we are going to use the Portal data again. The goal is 
to forecast rodent population size at annual (not monthly) resolution. The
key question is whether the rain and NDVI time series can help us predict
rodent abundance. In principle, those covariates should be useful: the 
Portal rodents are granivores, plants should produce more seeds in "good"
years, and in a water limited system like Portal, high rainfall should make
for a good year which will be reflected in high NDVI. So we will compare a 
null model without those covariates to a null model that includes one or 
the other.

### Preliminary steps ###

1. Download the [Portal data](https://github.com/pbadler/forecasting-dynamics-course/blob/master/data/portal_timeseries.csv)

2. Aggregate the monthly data to annual time scale using the final chunk of the
[introduction to forecasting lecture](./../lectures/ts-forecast-intro) as an example. Don't be surprised if this turns out to be the most challenging part of the assignment! 
      + For the rodents, just grab the May population count (month 5), since the rodent population peaks in May, on average. 
      + For the rain and NDVI covariates, sum months 1 to 4 (winter and early spring). The idea is that a wet and green winter and early spring might lead to high rodent counts in May.
      + Finally, merge/join the May rodent data frame with the aggregated rain and NDVI data frame.

3. Turn the rodent, rain, and NDVI data columns into time series objects.

Now you should be ready to fit some ARIMA models.

### Questions ###

1. Conduct some exploratory data analyses of your choice (e.g. time series
plots, bivariate scatter plots) to look for the relationship between
rain and rodents and NDVI and rodents. What do you see? Your answers should 
be one or more figures with a short commentary.

2. Use the `Arima()` function to fit a time series model to the annual rodent 
time series. Set the differencing and moving average dimensions to zero. What 
dimension should you use for autocorrelation? Justify your decision.

3. Use the `forecast()` function to generate a forecast based on the model
from question 2. Forecast for three years (set `h=3`) and show the 
80% and 95% confidence bands. Your answer will just be the figure.

4. Now add covariates to the ARIMA model you fit in question 2. Add rain 
as the covariate, then try NDVI as the covariate. Compare these models to 
the no covariate model using AIC. Does either rain or NDVI improve the model?

5. Generate three year forecasts for the rain and the NDVI models. To do this,
you will need to supply the covariates in the future years by specifying new
values for `xreg`. The syntax should look like:
```
my_forecast = forecast(my_fit, xreg=c(50,50,50),h=3)
```
Rather than using observed data for rain and NDVI, generate forecasts for three 
consecutive years with just 10% of average rain or NDVI, then generate forecasts
for three consecutive years with 200% of average rain or NDVI (show the figures). 
How different are these forecasts? Given your answer to question 4, is this a 
surprise? What do your results imply about the potential for this approach
to help anticipate the effects of decadal-scale climate change on Portal rodents?

6. *Optional bonus question* If you use function `auto.arima()` to fit these models,
would your answer to questions 1-5 change? (Remember to set `seasonal=FALSE`.)

Submit your group's code along with a separate document containing answers to the questions as an attachment on Canvas.

