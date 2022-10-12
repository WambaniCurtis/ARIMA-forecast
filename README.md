# Forecasting EURO/KEN Exchange Rates using ARIMA

## ARIMA

The Autoregressive Integrated Moving Average model, or ARIMA in short is a standard statistical method for time series forecast and analysis.
It is a generalisation of the simpler ARMA and adds the notion of integration.The acronym is descriptive,capturing the key aspects of the model itself.Briefly,they are:
* **AR**: A model that uses the dependent relationship between an observation and some number of lagged observations.
* **I**: The use of differencing of raw observations in order to make the series stationary.
* **MA**: A model that uses the dependecy between an observation and residual errors from a moving average model applied to lagged observations.

Each of these components are explicitly specified in the modek as a parameter.A standard notation is used of ARIMA(p,d,q) where the parameters
are substituted with integer values to quickly indicate the specific ARIMA model being used. The parameters of the model are defined as follows:

* **p**: The number of lag observations included in the model,also the lag order.
* **d**: The number of times that the raw observations are differenced,also the degree of differencing.
* **q**: The size of the moving average window,also the order of the Moving Average.


## About Data
The data can be accessed at [Central Bank of Kenya](https://www.centralbank.go.ke/rates/forex-exchange-rates/).


