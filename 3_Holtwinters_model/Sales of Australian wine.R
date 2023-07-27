#sales of Australian wine
www <- "D:\\��ѧ����\\�о���\\ʱ������\\data\\chapter3 wine.dat.txt"
wine.dat <- read.table(www, header = T) ; 
attach (wine.dat)
sweetw.ts <- ts(sweetw, start = 1980, freq = 12)
plot(sweetw.ts, xlab= "Time (months)", ylab = "sales (1000 litres)")
sweetw.decom<-decompose(sweetw.ts,type="mult")
plot(sweetw.decom)
sweetw.hw <- HoltWinters (sweetw.ts, seasonal = "mult")
sweetw.hw ; sweetw.hw$coef ; sweetw.hw$SSE
sweetw.mse = sqrt(sweetw.hw$SSE /length(sweetw))
plot (sweetw.hw$fitted)
plot (sweetw.hw)
