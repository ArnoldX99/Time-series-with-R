# HomeWork4

**徐润奇 2220009454**

## Simulation in R

```R
set.seed(1)
w <- rnorm(100)
plot(w, type = "l")
x <- seq(-3,3, length = 1000)
hist(rnorm(100), prob = T); points(x, dnorm(x), type = "l")
```

![image-20221123115414391](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123115414391.png)

![image-20221123115437798](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123115437798.png)

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

![image-20221123115745129](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123115745129.png)

The ACF is :

![image-20221123115800569](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123115800569.png)

The PACF is :

![image-20221123115841636](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123115841636.png)

The coefficients of AR(1) model is :

![image-20221123115935722](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123115935722.png)

## 4.Write a program

![image-20221123120053082](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123120053082.png)

![image-20221123120103833](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123120103833.png)

### (a). 

Simulate a time series of length 1000 for the following model, giving appropriate R code  and placing the simulated data in a vector x

```R
set.seed(123)
x <- w <- rnorm(1000)
for (t in 3:1000) x[t] <- 5/6*x[t-1] - 1/6*x[t-2] + w[t]
plot(x, type = "l")
```

![image-20221123120456212](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123120456212.png)

### (b). 

Plot the correlogram and partial correlogram for the simulated data. Comment on  the plots.

```R
acf(x)
pacf(x)
```

![image-20221123120815648](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123120815648.png)

![image-20221123120829208](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123120829208.png)

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

![image-20221123121209378](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123121209378.png)

### (d) 

Construct 95% confidence intervals for the parameter estimates of the fitted model.  Do the model parameters fall within the confidence intervals? Explain your results.

```R
x.ar$ar[1] + c(-2,2) * sqrt(x.ar$asy.var[1,1])

x.ar$ar[2] + c(-2,2) * sqrt(x.ar$asy.var[2,2])
```

![image-20221123121436562](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123121436562.png)

Using the ar function, we can get the ideal order = 2 based on **AIC**. The parameter estimate for the fitted AR(1) model are 𝛼̂1 = 0.8035477 and 𝛼̂2 = −0.1745147 respectively. Comparing to the underlying model 𝛼1 = 0.833 and 𝛼2 = 0.167, the approximate 95% confidence interval does contain the value of  the model parameters as expected, giving us no reason to doubt the implementation  of the model

### (e)

 Is the model in Equation stationary or non-stationary?

![image-20221123122429698](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123122429698.png)

![image-20221123122441421](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123122441421.png)

### (f) 

Plot the correlogram of the residuals of the fitted model, and comment on the plot.

```R
acf(x.ar$resid[-(1:2)])
```

![image-20221123122531663](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221123122531663.png)

The correlogram of the residual series for AR(2) model fitted to the simulated  series. The correlogram is approximately white noise so that, in the absence of  further information, the correlation and trends can be explained.