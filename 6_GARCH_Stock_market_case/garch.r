
#��ȡ����
www <- read.table("D:/��ѧ����/�о���/ʱ������/Chapter6/601788.txt")
stock <- www[8]

#ת��Ϊʱ������
ts.stock <- ts(stock, frequency=30)

#�����������ʵ�ʱ������ͼ��
plot(ts.stock, ylab="log return", main="���֤ȯ Stock Price 30minsS")

#���������������е� ACF ͼ��
acf(ts.stock, main="ACF of log return")

#L jung����������
Box.test(ts.stock, lag=30, type="Ljung")

#���� {????_????} ���еľ�ֵ�Ƿ�����㣺
t.test(c(ts.stock))

#���� {|????_????|} ���С����� ACF��
acf(abs(ts.stock), main="���֤ȯ ���������ʾ���ֵ�� ACF ����")

#�� Ljung-Box ����������
Box.test(abs(ts.stock), lag=30, type="Ljung")

#�� {????_t^2} �� ACF:
acf(ts.stock^2, main="���֤ȯ����������ƽ���� ACF ����")

#�� {????_t^2} ������ Ljung-Box ���������飺
Box.test(ts.stock^2, lag=30, type="Ljung")



#����ArchTest����
"ArchTest" <- function(x, m=10){
  # Perform Lagrange Multiplier Test for ARCH effect of a time series
  # x: time series, residual of mean equation
  # m: selected AR order
  y <- (x - mean(x))^2
  T <- length(x)
  atsq <- y[(m+1):T]
  xmat <- matrix(0, T-m, m)
  for (j in 1:m){
    xmat[,j] <- y[(m+1-j):(T-j)]
  }
  lmres <- lm(atsq ~ xmat)
  summary(lmres)
}

#�� ???????? = ???????? ??? ?????? �ȶ�{a????^2 } �� Ljung-Box ���������飺
Box.test((ts.stock - mean(ts.stock))^2,lag=30, type="Ljung")

# Arch����
ArchTest(ts.stock - mean(ts.stock), m=30)


#������̬�����ֲ����� GARCH(1,1) ģ�ͣ�
library(fGarch, quietly = TRUE)
mod1 <- garchFit(~ 1 + garch(1,1), data=ts.stock, trace=FALSE)
summary(mod1)

# ��ϵĲ�����ͼ�Σ�
vola <- volatility(mod1)
plot(ts(vola, start=start(ts.stock), frequency=frequency(ts.stock)),
     xlab=" ����", ylab=" ������")
abline(h=sd(ts.stock), col="green")

#��׼���в��ʱ������ͼ��
resi <- residuals(mod1, standardize=TRUE)
plot(ts(resi, start=start(ts.stock), frequency=frequency(ts.stock)),
     xlab=" mins", ylab=" ��׼���в�")

# a_t��a_t^2��ACF
resi <- residuals(mod1, standardize=TRUE)
acf(resi, lag.max=30, main="")
resi <- residuals(mod1, standardize=TRUE)
acf(resi^2, lag.max=30, main="")


#95%Ԥ������
vola <- volatility(mod1)
hatmu <- coef(mod1)["mu"]
lb.stock<- hatmu - 2*vola
ub.stock <- hatmu + 2*vola
ylim <- range(c(ts.stock, lb.stock, ub.stock))
x.stock <- c(time(ts.stock))
plot(x.stock, c(ts.stock), type="l",
     xlab=" 30mins", ylab=" ����������")
lines(x.stock, c(lb.stock), col="red")
lines(x.stock, c(ub.stock), col="red")

