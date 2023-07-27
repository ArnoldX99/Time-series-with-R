data(AirPassengers)
AP <- AirPassengers
AP
summary(AP)
class(AP)
start(AP); end(AP); frequency(AP)
plot(AP, ylab = "Passengers(1000's)")
layout(1:1)
plot(aggregate(AP))
layout(1:1)
boxplot(AP ~ cycle(AP))
