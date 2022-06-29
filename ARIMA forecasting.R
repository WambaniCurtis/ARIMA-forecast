# ARIMA forecasting of EURO/KEN exchange rates

## Loading the libraries
library(tidyverse)
library(forecast)
library(readr)
library(tseries)
library(tidyr)

## Loading the data

CBK_data <- read_csv("C:/Users/admin/Desktop/Time Series/ARIMA Forecasting/ARIMA forecast/Euro-Ken rates.csv")
attach(CBK_data)

sum(is.na(CBK_data)) # checking for missing values

## Visual plot of the time series plot

plot.ts(CBK_data$Mean,ylab="mean",main="EURO/KEN exchange rate")

## ACF and PACF plots for the series to view stationarity

acf(CBK_data$Mean,main= "ACF of mean exchange rate")

pacf(CBK_data$Mean,main="pacf of mean exchange rate")

## ADF test for stationarity
adf.test(CBK_data$Mean,alternative = "stationary")


## creating a time series object
mean_TSobject=ts(CBK_data$Mean)
clean_count=tsclean(mean_TSobject)

plot.ts(clean_count)

## Decomposition of the time series

mean_count=ts(na.omit(clean_count),freq=30)
decomp=stl(mean_count,s.window = "periodic")
deseasonal_count<-seasadj(decomp)  # used in ARIMA 
plot(decomp)

Acf(mean_count)

## Differencing the series to achieve stationarity

diff_mean<- diff(deseasonal_count,differences = 1)
plot(diff_mean)
adf.test(diff_mean,alternative = "stationary") # to check for stationarity.

Acf(diff_mean) # shows stationarity has been achieved.
Pacf(diff_mean)


## Auto correlations and choosing model order.(serious lag at 16)
### Getting an auto_fit p,d,q values

fit<-auto.arima(deseasonal_count,seasonal = FALSE)
summary(fit)  ## ARIMA(0,0,1)  for non-seasonal models
tsdisplay(residuals(fit),lag.max = 100,main="(1,1,1) model residuals")

### serious lag at 18, modify q=18

fit_1<- arima(deseasonal_count,order = c(1,1,18))
tsdisplay(residuals(fit_1),lag.max = 30,main = "seasonal model residuals")

## forecast  new model
fcast<-forecast(fit_1,h=100)
plot(fcast)

## Testing model performance

hold<- window(ts(deseasonal_count),start = 2901)
fit_no_holdout<- arima(ts(deseasonal_count[-c(2901:3000)]),order = c(1,1,18))
fcast_no_holdout<- forecast(fit_no_holdout,h=100)
plot(fcast_no_holdout)
lines(ts(deseasonal_count))

## Restoring seasonality to the data

fit_w_seasonality<- auto.arima(deseasonal_count,seasonal = T)
seasonal_fcast<- forecast(fit_w_seasonality,h=100)
plot(seasonal_fcast)
lines(deseasonal_count)


# FINAL TESTING OF THE MODEL
tsdisplay(residuals(fit_w_seasonality),lag.max = 30,main = "seasonal model residuals")

## Evidence exists at lag 20, higher order q=20 is necessary

fcast_1<- forecast(fit_1,h=100)
plot(fcast_1)

par(mfrow=c(2,1))
plot(fcast_1)
plot(seasonal_fcast)




















































