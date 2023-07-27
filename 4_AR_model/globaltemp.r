www <- 'D://教学资料//研究生//时间序列//data//chapter1 global.txt'
global <- scan(www)
global.ts <- ts(global, st = c(1856, 1), end = c(2005, 12),fr = 12)
global.decom <- decompose(global.ts)
# Plot the decomposed figure
plot(global.decom,)
Trend <- global.decom$trend
Seasonal <- global.decom$seasonal
ts.plot(cbind(Trend, Trend + Seasonal), lty = 1:2)

# Correlogram
global.random <- global.decom$random
acf_random <- acf(global.random,na.action = na.pass)$acf

# Holt-Winters model
global.hw0 <- HoltWinters(global.ts, seasonal = "mult")
plot(global.hw0)
global.hw <- HoltWinters(global.ts, seasonal = "add")
plot(global.hw)

global.hw0$SSE
global.hw$SSE  #Judge by SSE
global.hw$coefficients

