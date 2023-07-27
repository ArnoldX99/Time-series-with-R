www <- "D:\\教学资料\\研究生\\时间序列\\data\\chapter1 CBE.txt"
CBE <- read.table(www, header = T)
CBE[1:4, ]
class(CBE)
Elec.ts <- ts(CBE[, 3], start = 1958, freq = 12)
Beer.ts <- ts(CBE[, 2], start = 1958, freq = 12)
Choc.ts <- ts(CBE[, 1], start = 1958, freq = 12)
plot(cbind(Elec.ts, Beer.ts, Choc.ts))
#the three series constitute a multiple time series

