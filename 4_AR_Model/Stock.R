www <- read.table("D://教学资料//研究生//时间序列//data//chapter11 us_rates.txt",head = TRUE)
Z <- www[2]
Z.ts <- ts(Z)
Z.ar <- ar(Z.ts)
mean(Z.ts)
Z.ar$order
Z.ar$ar
Z.ar$ar[2] + c(-2, 2)*sqrt(Z.ar$asy.var[1,1])
acf(Z.ar$res[-1])
#In the code above, a “???1” is used in the vector of
#residuals to remove the first item from the residual 
#series
#z_t = 2.8 + 0.89(z_t-1 - 2.8)

