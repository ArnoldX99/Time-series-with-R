# (a)
set.seed(123)
x <- w <- rnorm(1000)
for (t in 3:1000) x[t] <- 5/6*x[t-1] - 1/6*x[t-2] + w[t]
plot(x, type = "l")
#(b) Plot the correlogram and partial correlogram for the simulated data. Comment on 
#the plots
acf(x)
pacf(x)
#(c) Fit an AR model to the data in ???? giving the parameter estimates and order of the 
#fitted AR process.

x.ar <- ar(x, method = "mle")
cat("\nThe order of AR process is:" ,x.ar$order,"\n")
## 
## The order of AR process is: 2
cat("\nThe parameter estimates of the AR process are:", x.ar$ar[1], " a
nd ", x.ar$ar[2], "respectively.\n")
## 
## The parameter estimates of the AR process are: 0.8035477 and -0.17
#45147 respectively.

#(d) Construct 95% confidence intervals for the parameter estimates of the fitted model. 
#Do the model parameters fall within the confidence intervals? Explain your results.
x.ar$ar[1] + c(-2,2) * sqrt(x.ar$asy.var[1,1])
x.ar$ar[2] + c(-2,2) * sqrt(x.ar$asy.var[2,2])

#(e) stationary
#(f) Plot the correlogram of the residuals of the fitted model, and comment on the plot.

  
