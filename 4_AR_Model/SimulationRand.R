set.seed(1)
w <- rnorm(100)
plot(w, type = "l")
x <- seq(-3,3, length = 1000)
hist(rnorm(100), prob = T); points(x, dnorm(x), type = "l")


