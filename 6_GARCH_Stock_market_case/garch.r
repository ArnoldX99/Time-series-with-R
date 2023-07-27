
#读取数据
www <- read.table("D:/教学资料/研究生/时间序列/Chapter6/601788.txt")
stock <- www[8]

#转化为时间序列
ts.stock <- ts(stock, frequency=30)

#作对数收益率的时间序列图：
plot(ts.stock, ylab="log return", main="光大证券 Stock Price 30minsS")

#作对数收益率序列的 ACF 图：
acf(ts.stock, main="ACF of log return")

#L jung白噪声检验
Box.test(ts.stock, lag=30, type="Ljung")

#检验 {????_????} 序列的均值是否等于零：
t.test(c(ts.stock))

#考虑 {|????_????|} 序列。作其 ACF：
acf(abs(ts.stock), main="光大证券 对数收益率绝对值的 ACF 估计")

#作 Ljung-Box 白噪声检验
Box.test(abs(ts.stock), lag=30, type="Ljung")

#作 {????_t^2} 的 ACF:
acf(ts.stock^2, main="光大证券对数收益率平方的 ACF 估计")

#对 {????_t^2} 序列作 Ljung-Box 白噪声检验：
Box.test(ts.stock^2, lag=30, type="Ljung")



#定义ArchTest方程
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

#令 ???????? = ???????? ??? ?????? 先对{a????^2 } 作 Ljung-Box 白噪声检验：
Box.test((ts.stock - mean(ts.stock))^2,lag=30, type="Ljung")

# Arch检验
ArchTest(ts.stock - mean(ts.stock), m=30)


#采用正态条件分布建立 GARCH(1,1) 模型：
library(fGarch, quietly = TRUE)
mod1 <- garchFit(~ 1 + garch(1,1), data=ts.stock, trace=FALSE)
summary(mod1)

# 拟合的波动率图形：
vola <- volatility(mod1)
plot(ts(vola, start=start(ts.stock), frequency=frequency(ts.stock)),
     xlab=" 分钟", ylab=" 波动率")
abline(h=sd(ts.stock), col="green")

#标准化残差的时间序列图：
resi <- residuals(mod1, standardize=TRUE)
plot(ts(resi, start=start(ts.stock), frequency=frequency(ts.stock)),
     xlab=" mins", ylab=" 标准化残差")

# a_t与a_t^2的ACF
resi <- residuals(mod1, standardize=TRUE)
acf(resi, lag.max=30, main="")
resi <- residuals(mod1, standardize=TRUE)
acf(resi^2, lag.max=30, main="")


#95%预测区间
vola <- volatility(mod1)
hatmu <- coef(mod1)["mu"]
lb.stock<- hatmu - 2*vola
ub.stock <- hatmu + 2*vola
ylim <- range(c(ts.stock, lb.stock, ub.stock))
x.stock <- c(time(ts.stock))
plot(x.stock, c(ts.stock), type="l",
     xlab=" 30mins", ylab=" 对数收益率")
lines(x.stock, c(lb.stock), col="red")
lines(x.stock, c(ub.stock), col="red")

