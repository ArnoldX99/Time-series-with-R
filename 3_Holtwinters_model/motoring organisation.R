#complains to a motoring organisation
www <- "D:\\教学资料\\研究生\\时间序列\\data\\chapter3 motororg.dat.txt"
Motor.dat <- read.table(www, header = T)
attach(Motor.dat)
Comp.ts <- ts(complaints, start = 1996, freq = 12)
plot(Comp.ts, xlab = "Time / months", ylab = "Complaints")

Comp.hw1 <- HoltWinters(complaints, beta = F, gamma = F) 
Comp.hw1
plot(Comp.hw1)
Comp.hw1$SSE
#alpha = 0.2
Comp.hw2 <- HoltWinters(complaints, alpha = 0.2, beta=F, gamma=F)
plot(Comp.hw2)
Comp.hw2$SSE

