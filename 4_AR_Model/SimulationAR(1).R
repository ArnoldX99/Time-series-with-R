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

