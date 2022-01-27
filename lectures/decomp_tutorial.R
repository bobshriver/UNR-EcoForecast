######
##Timeseries decomp  (adapted from Peter Adler)
#####




library(forecast)
library(stlplus)
library(fpp)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))##set working directory to current file 


## Inherent scales within a time series:
#  Often our data has some frequency of collection within a year (e.g. daily, monthly).
#  We might be interested in either focusing on that scale, or removing the effects of it.
#  For example - seasonally adjusted housing sales or unemployment.


## Time series decomposition:
# a time series approach for trying to pull out the signals at different scales.
# Breaks down a time series into the trend, seasonal, and "irregular" fluctuations
# Use example of atmospheric CO2.

# To extract these components, there are generally 3 basic steps.
# 1) we fit something to the observed data to extract the long-term trend
# 2) we fit a seasonal model to the remaining data to pull out the seasonal signal
# 3) whatever is left over are the irregular fluctuations (residuals)


## Time Series Objects

# To do a time series decomp using existing packages, we need our data to be a time series object.
# This is a data format, like a dataframe is a format, that has a special structure and R
# knows to work with it in a special way.

# Some packages will require you to put your data into a time series object specific to that
# package. For today, we will use the standard ts object in the base package. It's limitation is
# that it can only take regularly spaced data (i.e. monthly, daily, quarterly, annual). There are
# other methods that can take irregular data and import that into a time series object. Packages
# that can handle irregular data include zoo and xts.

## Example: ts

# Exploring  patterns with decomposition using NDVI
# need to make sure your data is already in chronological order

NDVI = read.csv('./../data/portal_timeseries.csv', stringsAsFactors = FALSE)
head(NDVI)

NDVI.ts = ts(NDVI$NDVI, start = c(1992, 3), end = c(2014, 11), frequency = 12)
plot(NDVI.ts, xlab = "Year", ylab="greenness")

class(NDVI.ts)
NDVI.ts
start(NDVI.ts)
end(NDVI.ts)

# You cannot slice and dice a ts object without losing the date info, unless you
# use a special tool
str(NDVI.ts)
data.2000 = window(NDVI.ts, start=c(1999,1),end=c(2000,12))
data.2000

# Extracting a trend

# a moving average is a classic way of extracting the 'cross year'  
# pattern in the data

# We lose data on the front and back because as the name implies it is 
# averaging over a window of values. Order is the size of the window. 

MA_m13 = ma(NDVI.ts, order=13, centre = TRUE)

plot(NDVI.ts)
lines(MA_m13, col="blue", lwd = 3)

# try a longer window
MA_m49 = ma(NDVI.ts, order=49, centre = TRUE)

plot(NDVI.ts)
lines(MA_m49, col="blue", lwd = 3)



# Classic Decomposition uses a Moving Average to obtain a trend, then detrend the observed data.

# Two basic ways to remove a seasonal signal - additive or multiplicative. 
# Additive: Observed = Trend + Seasonal + Irregular (fluctuations in the time series stable with trend)
# Multiplicative: Observed = Trend*Seasonal*Irregular (fluctuations in the time series increase with trend)
# In our data, not much of a trend, no clear relationship between trend and seasonality

Seasonal_residual_add = NDVI.ts - MA_m49
plot(Seasonal_residual_add)

Seasonal_residual_multi = NDVI.ts/MA_m49
plot(Seasonal_residual_multi)

# So, we've pulled out the trend. What does this plot represent? What's still left in here?
# Seasonal signal and the "random" signal. The next step is to disentangle those two signals.

# We walked through pulling out the trend signal because I wanted you to have a basic understanding
# of what's going on with decomposition approaches. But we don't have to disentangle all
# these signals by hand. There are packages that do this. 

# So let's take our NDVI data and run it through one of these standard 
# decomposition packages.

fit_add = decompose(NDVI.ts, type = 'additive')
plot(fit_add)
str(fit_add)

fit_mult = decompose(NDVI.ts, type = 'multiplicative')
plot(fit_mult)
str(fit_mult)

# It's hard to see the seasonal pattern, so let's zoom in.
# by subsetting the seasonal fits:
plot(fit_add$seasonal[11:23],type="o") # started at 11 b/c it is the first January

# Would we get the same answer just by calculating monthly means?
# Use tapply() and cycle():
monthly_means <- tapply(NDVI.ts, cycle(NDVI.ts), FUN=mean)
plot(monthly_means,type="o")

# In our case slight differences in our seasonal and irregular signals with + vs X
# both of them are picking up a big summer peak in greeness and a smaller winter peak

# Anything odd about the seasonal signal?

# Different approaches make different assumptions about the stability of the seasonal signal.
# This approach assumes that there is no change in the pattern of seasonality - except 
# an effect of trend magnitude in the multiplicative model.

# Is also sensitive to outliers and you lose info at the beginning and end of the series

# At the other end of the spectrum is STL decomposition
# Advantages: Seasonal component can change through time
# user can control the trend averaging and
# can control sensitivity to outliers. Less impact on trend and season, but irregular remains

# # Drawbacks: no ability to handle calendar variation, only additive. To make it give you
# # a multiplicative requires logs and back transformations.
# 
# fit_stl = stl(NDVI.ts, s.window='periodic', robust=TRUE)
# plot(fit_stl)
# str(fit_stl) # can find what windows it was using
# fit_stl$time.series # can extract data
# 
# fit_stl_12mo = stl(NDVI.ts, t.window=13, s.window='periodic', robust=TRUE)
# plot(fit_stl_12mo)
# 
# fit_stl_24mo = stl(NDVI.ts, t.window=25, s.window=7, robust=TRUE)
# plot(fit_stl_24mo)
# str(fit_stl_24mo)

# How to choose windows sizes for seasonal vs. trend? An art. 
# But there are some rules to the art. First, the trend window must be
# larger than the season window - odd orders
# (1.5* number of observations in a seasonal cycle)/(1-1.5*seasonal smooth order^-1)
# for monthly data, the number of observations in a seasonal cycle is 12
# 
# library(stlplus)
# season_window = 7
# min_twindow = as.integer(1.5*12/(1-1.5*season_window^-1))

# # wiggles are bad and means that the s.window is not large enough
# s_7 = stlplus(NDVI.ts, s.window = season_window, t.window = min_twindow)
# plot_seasonal(s_7)
# 
# season_window = 13
# min_twindow = (1.5*12)/(1-1.5*season_window^-1)
# s_13 = stlplus(NDVI.ts, s.window = season_window, t.window = 21)
# plot_seasonal(s_13)
# 
# season_window = 25
# min_twindow = (1.5*12)/(1-1.5*season_window^-1)
# s_25 = stlplus(NDVI.ts, s.window = season_window, t.window = 21)
# plot_seasonal(s_25)
# 
# plot(s_25)
# plot_trend(s_25)


