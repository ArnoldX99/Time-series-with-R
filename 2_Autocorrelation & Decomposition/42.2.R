ssv <- matrix(c(39, 35, 16, 18, 7, 22, 13, 18, 20, 9, -12, -11, -19, -9, -2, 16))
colnames(ssv) <- "ssv"
ccv <- matrix(c(47, -26, 42, -10, 27, -8, 16, 6, -1, 25, 11, 1, 25, 7, -5, 3))
colnames(ccv) <- "ccv"
# Produce time plots of the two time series
ssv.ts <- ts(ssv)
ccv.ts <- ts(ccv)
ts.plot(ssv.ts)
ts.plot(ccv.ts)
# For each time series, draw a lag 1 scatter plot.
plot(ssv.ts[1:15],ssv.ts[2:16])
plot(ccv.ts[1:15],ccv.ts[2:16])
# Produce the acf for both time series and comment
acf_ssv <- acf(ssv.ts)$acf
acf_ccv <- acf(ccv.ts)$acf
