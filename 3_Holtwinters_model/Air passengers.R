#four year ahead forecasts for the air passenger data
data(AirPassengers)
AP <- AirPassengers
AP.hw <- HoltWinters(AP, seasonal = "mult")
plot(AP.hw)
AP.predict <- predict(AP.hw, n.ahead = 4 * 12)
ts.plot(AP, AP.predict, lty = 1:2)
S
