# 7_More_About_Garch


## (a) Plot the Amsterdam series and the first-order differences of the series. Comment on  the plots.

```R
stock <- read.table("D://data//chapter11 us_rates.txt",head = TRUE)
Ams.ts <- ts(stock[,1], start=1986, frequency = 365)
plot(Ams.ts)
plot(diff(Ams.ts))
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/af12f318-f561-490c-98f4-33fca77523f9)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/22a54d19-7f62-47b8-b9ff-9934d36a851d)

The figure shows that after the first-order differences, the increasing trend of the Amsterdam  series is no longer apparent.



## b) Fit the following models to the Amsterdam series, and select the best fitting model:  ARIMA(0,1,0);ARIMA(1,1,0);ARIMA(0,1,1),ARIMA(1,1,1).

```R
library(forecast)
arima(Ams.ts, order = c(0, 1, 0))
arima(Ams.ts, order = c(1, 1, 0))
arima(Ams.ts, order = c(0, 1, 1))
arima(Ams.ts, order = c(1, 1, 1))
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/a9378a3d-54f5-4cef-88fb-8f03ff30835f)

From above all model, we can see **ARIMA(0,1,1)** is the best one with the least AIC.

## (c) Produce the correlogram of the residuals of the best-fitting model and the  correlogram of the squared residuals. Comment.

```R
best <- arima(Ams.ts, order = c(0,1,0))
acf(resid(best))
acf(resid(best)^2)
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/590f9f97-4c6a-4260-9f9a-832152630563)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/5436aac0-9514-4edd-a1a5-372991425519)

The correlogram of residuals from the ARIMA(0,1,0) model is plotted. To investigate  volatility, the correlogram of the squared residuals is found. We can observe from the  figures that the seasonal effects exist in the residuals series, and since the squared residuals  are correlated at most lags, it gives the evidence of volatility. Hence, a GARCH model is  fitted  for the residual series.

## (d) Fit the following GARCH models to the residuals, and select the best-fitting  model :GARCH(0,1), GARCH(1,0), GARCH(1,1), and GARCH(0,2). Give the estimated  parameters of the best-fitting model.

```R
library(tseries)

Ams.garch0_1 <- garch(resid(best), order = c(0,1), grad = 'numerical
', trace = F)
AIC(Ams.garch0_1)

Ams.garch1_0 <- garch(resid(best), order = c(1,0), grad = 'numerical
', trace = F)
AIC(Ams.garch1_0)

Ams.garch1_1 <- garch(resid(best), order = c(1,1), grad = 'numerical
', trace = F)
AIC(Ams.garch1_1)

Ams.garch0_2 <- garch(resid(best), order = c(0,2), grad = 'numerical
', trace = F)
AIC(Ams.garch0_2)

```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/3f673efd-2815-42a1-a4c9-a338eeb85ebc)

 We can choose the best fitting model  GARCH(1,1). 

```R
Ams.garch1_1
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/5fba400a-bb39-400b-b1df-230d16312ab4)

We can see that the coefficients of the fitted GARCH model are all  statistically significant, since zero does not fall in any of the confidence intervals.

## (e) Plot the correlogram of the residuals from the best fitting GARCH model. Plot the  correlogram of the squared residuals from the best fitting GARCH model, and comment  on the plot.

```R
acf(Ams.garch1_1$res[-1])
acf(Ams.garch1_1$res[-1]^2)
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/aacfc2bb-8186-4687-98e5-fa510a99de73)



![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/55826e57-6a55-4b10-b133-ca65513e96ad)



Both correlograms of the residuals of the fitted GARCH(1,1) model shows no obvious  patterns or significant values, behaving like White Noise, so we can indicate that a  satisfactory fit has been obtained.

