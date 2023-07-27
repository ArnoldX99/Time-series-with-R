# 4_AR_Model

## Simulation in R

```R
set.seed(1)
w <- rnorm(100)
plot(w, type = "l")
x <- seq(-3,3, length = 1000)
hist(rnorm(100), prob = T); points(x, dnorm(x), type = "l")
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/5a9e6170-c6af-4d7b-9fd7-f59f4cf45022)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/f29703dc-4d9f-4c67-9ec4-92e2d5a51777)

## 4.5.7 Simulation

```R
set.seed(1)
x <- w <- rnorm(100)
for (t in 2:100) x[t] <- 0.7 * x[t - 1] + w[t]
plot(x, type = "l")
acf(x)
pacf(x)
x.ar <- ar(x, method = "mle")
x.ar$order
x.ar$ar
x.ar$ar[1] + c(-2,2) * sqrt(x.ar$asy.var[1,1])
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/3f9cf29b-f7c1-4219-b2c6-068b80f9a756)

The ACF is :

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/9e58da56-5046-4bd3-9dec-fe9b67a0b6c7)

The PACF is :

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/05eb2eac-2124-414f-a64d-7497857bcfad)

The coefficients of AR(1) model is :

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/224a5e32-4235-4e51-bdbc-619ba398db04)

## 4.Write a program

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/f3447265-fc3e-4264-985d-2848aabdcc7f)

### (a). 

Simulate a time series of length 1000 for the following model, giving appropriate R code  and placing the simulated data in a vector x

```R
set.seed(123)
x <- w <- rnorm(1000)
for (t in 3:1000) x[t] <- 5/6*x[t-1] - 1/6*x[t-2] + w[t]
plot(x, type = "l")
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/db920a45-39ac-4c66-9d3d-54e8b61b17a0)

### (b). 

Plot the correlogram and partial correlogram for the simulated data. Comment on  the plots.

```R
acf(x)
pacf(x)
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/ebb1f0d2-351a-45ee-a7e4-41eb7d6086c2)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/ae07a3d8-1a35-40e5-bb5d-182eb543169f)

There is a gradual  exponential decay in the correlations, and We can observe from the partial  correlogram that it has no significant correlations except the value at lag 1 and lag 2.  Thus, we can assume that this simulated data suits the AR(2) process.

### (c) 

Fit an AR model to the data in 𝑥 giving the parameter estimates and order of the  fitted AR process.

```R
x.ar <- ar(x, method = "mle")
cat("\nThe order of AR process is:" ,x.ar$order,"\n")
## 
## The order of AR process is: 2
cat("\nThe parameter estimates of the AR process are:", x.ar$ar[1], " a
nd ", x.ar$ar[2], "respectively.\n")
## 
## The parameter estimates of the AR process are: 0.8035477 and -0.17
45147 respectively.
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/5b4d53a5-1ac4-419d-8bb8-6cedf7ad791a)

### (d) 

Construct 95% confidence intervals for the parameter estimates of the fitted model.  Do the model parameters fall within the confidence intervals? Explain your results.

```R
x.ar$ar[1] + c(-2,2) * sqrt(x.ar$asy.var[1,1])

x.ar$ar[2] + c(-2,2) * sqrt(x.ar$asy.var[2,2])
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/f8f0a369-636c-4f24-ad21-c64a83a671ff)

Using the ar function, we can get the ideal order = 2 based on **AIC**. The parameter estimate for the fitted AR(1) model are 𝛼̂1 = 0.8035477 and 𝛼̂2 = −0.1745147 respectively. Comparing to the underlying model 𝛼1 = 0.833 and 𝛼2 = 0.167, the approximate 95% confidence interval does contain the value of  the model parameters as expected, giving us no reason to doubt the implementation  of the model

### (e)

 Is the model in Equation stationary or non-stationary?

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/24b94dec-4db9-4957-8d13-95350db4749a)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/6116f089-a462-453a-a0e1-e83cd2b93a42)

### (f) 

Plot the correlogram of the residuals of the fitted model, and comment on the plot.

```R
acf(x.ar$resid[-(1:2)])
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/633355b4-02b9-4ff6-b4d2-9514f65410d2)

The correlogram of the residual series for AR(2) model fitted to the simulated  series. The correlogram is approximately white noise so that, in the absence of  further information, the correlation and trends can be explained.
