CBE <- read.table("D:\\教学资料\\研究生\\时间序列\\data\\chapter1 CBE.txt", header = TRUE)
Elec.ts <- ts(CBE[,3], start = 1958, freq = 12)
plot(Elec.ts, xlab = "time", ylab = "Electricity productions")
plot(log(Elec.ts), xlab = "time", ylab = "Electricity productions(log)")

logElec <- log(Elec.ts)
Seas <- cycle(logElec)
Time <- time(logElec)
Elec.lm <- lm(logElec ~ 0 + Time + factor(Seas))
coef(Elec.lm)
AIC(Elec.lm)


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

plot(time(logElec), resid(logElec.lm2), type = 'l', ylab = 'Harmonic 
model')
abline(0, 0, col = 'blue')
acf(resid(logElec.lm2))
pacf(resid(logElec.lm2))


res.arH <- ar(resid(logElec.lm2))
res.arH$order
res.arH$ar


acf(res.arH$res[-(1:23)])


new.t <- time(ts(start = 1991, end = c(2000,12), fr = 12))
TIME <- (new.t - mean(time(Elec.ts)))/sd(time(Elec.ts))
SIN <- COS <- matrix(nr = length(new.t), nc = 6)
for (i in 1:6){
  COS[,i] <- cos(2 * pi * i *new.t)
  SIN[,i] <- sin(2 * pi * i *new.t)
}
SIN <- SIN[,-6]
new.dat <- data.frame(TIME = as.vector(TIME), SIN = SIN, COS = COS)
Elec.pred.ts <- exp(ts(predict(logElec.lm2, new.dat), st = 1991, fr = 12))
ts.plot(log(Elec.ts), log(Elec.pred.ts), lty = 1:2, main = 'Electricity
productions(1958-1990) and forecasts(1991-2000) in logarithm values')
ts.plot(Elec.ts, Elec.pred.ts, lty = 1:2, main = 'Electricity productio
ns(1958-1990) and forecasts(1991-2000) original series')

Elec.pred.ts

