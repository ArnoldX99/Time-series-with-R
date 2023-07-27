wave.dat <- "D:\\教学资料\\研究生\\时间序列\\data\\chapter2 wave.dat.txt"
wave <- read.table(wave.dat, header = TRUE)
attach(wave)
ts.plot(waveht) 
plot(ts(waveht[1:60]))
#the lag 1 autocorrelation for waveht
acf_1 <- acf(waveht)$acf
acf_2 <- acf(waveht)$acf[2]
plot(waveht[1:396],waveht[2:397])
