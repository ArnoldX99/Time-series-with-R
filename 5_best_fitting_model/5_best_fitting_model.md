# 5_best_fitting_model

### (a). Give two reasons why a log-transformation may be appropriate for the electricity  series.

```R
CBE <- read.table("D:\\data\\chapter1 CBE.txt", header = TRUE)
Elec.ts <- ts(CBE[,3], start = 1958, freq = 12)
plot(Elec.ts, xlab = "time", ylab = "Electricity productions")
plot(log(Elec.ts), xlab = "time", ylab = "Electricity productions(lo
g)")

```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/5dafc1c3-4d23-49c0-87c1-55acd387277f)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/aa056da3-7e09-4918-8158-6d26805a7701)

We have advantages of Logarithmization：

(1). The natural logarithm can be used to transform a model with multiplicative  components to a model with additive components.

(2). Transform big data to small one with less fluctuation.

(3). Keep the data be positive.

### (b) Fit a seasonal indicator model with a quadratic trend to the (natural) logarithm of  the series.

```R
logElec <- log(Elec.ts)
Seas <- cycle(logElec)
Time <- time(logElec)
Elec.lm <- lm(logElec ~ 0 + Time + factor(Seas))
coef(Elec.lm)
AIC(Elec.lm)
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/c6eb8217-b629-45be-8c45-c31cbae66740)

### (c) Fit a harmonic model with a quadratic trend to the logarithm of the series.

```R
SIN <- COS <- matrix(nr = length(logElec), nc = 6)
for (i in 1:6) {
COS[,i] <- cos(2*pi * i* time(logElec))
SIN[,i] <- sin(2*pi * i * time(logElec))
}
TIME <- (time(logElec) - mean(time(logElec)))/sd(time(logElec))
mean(time(logElec))
sd(time(logElec))

logElec.lm1 <- lm(logElec~TIME + I(TIME^2)+COS[,1]+SIN[,1]+COS[,2]+SIN[,2]+COS[,3]+SIN[,3]+COS[,4]+SIN[,4]+COS[,5]+SIN[,5]+COS[,6]+SIN[,6])
coef(logElec.lm1)/sqrt(diag(vcov(logElec.lm1)))
AIC(logElec.lm1)

logElec.lm2 <-lm(logElec~TIME+I(TIME^2)+COS[,1]+SIN[,1]+COS[,2]+SIN[,2]+COS[,3]+SIN[,5]+COS[,6])
coef(logElec.lm2)/sqrt(diag(vcov(logElec.lm2)))

AIC(logElec.lm2)

```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/0d3cf21d-cb32-471a-8c3e-8de019e0be3f)

### (d) Plot the correlogram and partial correlogram of the residuals from the overall bestfitting model and comment on the plots.

```R
plot(time(logElec), resid(logElec.lm2), type = 'l', ylab = 'Harmonic 
model')
abline(0, 0, col = 'blue')
acf(resid(logElec.lm2))
pacf(resid(logElec.lm2))
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/898bb8ec-5df8-4b5b-a097-d028ec505757)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/22bed431-192f-40a3-aec7-b9b1593237d8)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/1456cb9e-392f-4856-841e-e16a0714388f)

Comparing the AIC to the 3 fitted models, we can observe that the harmonic model  with statistically significant terms COS[,1], SIN[,1], COS[,2], SIN[,2], COS[,3], SIN[,5]  and COS[,6] selected has the least AIC. There is no discernible curve in the  series, which implies that a straight line is an adequate description of the trend.  And a tendency for the series to persist above the x-axis with cycle implies that the  series is positively autocorrelated and has seasonal effect.

### (e) Fit an AR model to the residuals of the best-fitting model. Give the order of the best-fitting AR model and the estimated model parameters.

```R
res.arH <- ar(resid(logElec.lm2))
res.arH$order
res.arH$ar
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/997bf9b2-277e-4974-90b3-b8ebd80444d0)



### (f) Plot the correlogram of the residuals of the AR model, and comment.

```R
acf(res.arH$res[-(1:23)])
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/3fe90300-846a-4dbb-8604-e88dd618761a)

We can get from the correlogram of the residual series for AR(23) model fitted  to the harmonic model. The correlogram is approximately white noise so that we  can assume that the correlation and trends can be explained with AR(23) model.



### (g) Write down in full equation of the best-fitting model.

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/15790f6b-f302-424e-854a-5506309d5799)

### (h) Use the best fitting model to forecast electricity production for the years 1991-2000.

```R
new.t <- time(ts(start = 1991, end = c(2000,12), fr = 12))
TIME <- (new.t - mean(time(Elec.ts)))/sd(time(Elec.ts))
SIN <- COS <- matrix(nr = length(new.t), nc = 6)
for (i in 1:6){
 COS[,i] <- cos(2 * pi * i *new.t)
 SIN[,i] <- sin(2 * pi * i *new.t)
}
SIN <- SIN[,-6]
new.dat <- data.frame(TIME = as.vector(TIME), SIN = SIN, COS = COS)
Elec.pred.ts <- exp(ts(predict(logElec.lm2, new.dat), st = 1991, fr = 1
2))
ts.plot(log(Elec.ts), log(Elec.pred.ts), lty = 1:2, main = 'Electricity
productions(1958-1990) and forecasts(1991-2000) in logarithm values')
ts.plot(Elec.ts, Elec.pred.ts, lty = 1:2, main = 'Electricity productio
ns(1958-1990) and forecasts(1991-2000) original series')

```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/9a700644-708e-4488-99ad-ac6344ad947f)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/8864ffd4-326c-497e-be8c-e93b36cb0379)

```R
Elec.pred.ts
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/a50cb11e-73f9-443e-a69a-f3656c19e798)





