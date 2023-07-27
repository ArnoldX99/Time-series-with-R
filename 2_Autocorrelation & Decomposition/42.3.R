www <- "D://教学资料//研究生//时间序列//data//chapter1 global.txt"
global <- scan(www)
global.ts <- ts(global, st = c(1856, 1), end = c(2005, 12),fr = 12)
# Decompose the series
global.decom= decompose(global.ts)
plot(global.decom)

#Produce a plot of the trend with a superimposed seasonal effect.
global.deseasonal <- global.ts - global.decom$seasonal
ts.plot(cbind(global.deseasonal,global.deseasonal+global.ts),lty =1:2)

#Compare the standard deviation of the original series with the deseasonalised series
sd(global.ts)
sd(global.deseasonal)


#Plot the correlogram of the residuals (random component) 
global.random <- global.decom$random
acf_random <- acf(global.random,na.action = na.pass)$acf
