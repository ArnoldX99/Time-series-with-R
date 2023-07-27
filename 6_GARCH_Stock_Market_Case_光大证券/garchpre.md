# Case of stock-market by using GARCH

以 光大证券(SH601788)股票的对数收益率为例。

![image-20221113190048557](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113190048557.png)

有 400个观测值。读入数据：

```R
www<- read.table("D:/教学资料/研究生/时间序列/Chapter6/601788.txt")
print(www)
stock <- www[8]
```

![image-20221113190422480](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113190422480.png)

## 1. Data Analysis

First of all we turn the data into time series with 30 mins. We note this series as $\left\{ r_t \right\}$.

```R
#转化为时间序列
ts.stock <- ts(stock, frequency=30)
#作对数收益率的时间序列图：
plot(ts.stock, ylab="log return", main="光大证券 Stock Price Monthly Log Return")
```

![image-20221113190613225](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113190613225.png)

![image-20221113190639046](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113190639046.png)

We can see from ACF figure of $\left\{ r_t \right\}$, with only a few lags slightly out of boundary, so we can consider it as a white noise.（这里的白噪声特指零均值、不相关的弱平稳时间序列）。

Then we apply ***Ljung Box white noise test***:

```R
Box.test(ts.stock, lag=30, type="Ljung")
```

![image-20221113202606695](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113202606695.png)

Since p-value is 0.083, it passed the white noise test at 0.05 level.

Then we test whether the mean of $\left\{ r_t \right\}$ is 0:

```R
t.test(c(ts.stock))
```

![image-20221113203201572](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113203201572.png)

We can see the mean approach to 0.

Then we consider about the $\left\{|r_t|\right\}$, so make an ACF figure of it:

```R
acf(abs(ts.stock), main="光大证券 对数收益率绝对值的 ACF 估计")
```

![image-20221113204802681](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113204802681.png)

We can see lots of values are out of bound. 

Apply the **Ljung-Box test**:

```R
Box.test(abs(ts.stock), lag=12, type="Ljung")
```

![image-20221113205220504](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113205220504.png)

The result significantly rejected the white noise null hypothesis. So we can say, $\left\{ |r_t|\right\}$ performs: stable, no correlation but not independent with terms nearby.

Furthermore we print the ACF and apply the Ljung-box test to $\left\{ r_t^2\right\}$ :

```R
acf(ts.stock^2, main="光大证券对数收益率平方的 ACF 估计")
Box.test(ts.stock^2, lag=30, type="Ljung")
```

![image-20221113215110737](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113215110737.png)

![image-20221113215143831](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113215143831.png)



The ACF estimation and white-noise test shows $\left\{r_t\right\}$ have the auto-correlation,not independent.

## 2. Construct model

First of all we need to test whether the data fits Garth model.

```R
#ArchTest检验（函数代码此处省略
ArchTest(ts.stock - mean(ts.stock), m=30)
```

![image-20221113221404065](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113221404065.png)

It passed the test, so it's proper way to use Garch.

We use normal distribution to construct GARCH model.

```R
#采用正态条件分布建立 GARCH(1,1) 模型：
library(fGarch, quietly = TRUE)
mod1 <- garchFit(~ 1 + garch(1,1), data=ts.stock, trace=FALSE)
summary(mod1)
```

![image-20221113230059090](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113230059090.png)

![image-20221113230150646](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113230150646.png)

![image-20221113230240955](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113230240955.png)

![image-20221113230311774](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113230311774.png)

![image-20221113230321821](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113230321821.png)

Then we try to fit the volatility figure.

```R
# 拟合的波动率图形：
vola <- volatility(mod1)
plot(ts(vola, start=start(ts.stock), frequency=frequency(ts.stock)),
     xlab=" 分钟", ylab=" 波动率")
abline(h=sd(ts.stock), col="green")
```

![image-20221113230528623](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221113230528623.png)

The green line is the standard error of the sample.

We can see from the figure: In the open time of morning and afternoon, the volatility reach a high level.

 

## 3. Test of the model

First we have an overview of standardized residual: 

```R
#标准化残差的时间序列图：
resi <- residuals(mod1, standardize=TRUE)
plot(ts(resi, start=start(ts.stock), frequency=frequency(ts.stock)),
     xlab=" mins", ylab=" 标准化残差")
```

![image-20221114121632320](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221114121632320.png)

We can see except some outliers, it satisfies the $idd$ (independent identically distributed).

Next we test the ACF of $\left\{ a_t \right\}$ and $\left\{ a_t^2 \right\}$ :

```R
resi <- residuals(mod1, standardize=TRUE)
acf(resi, lag.max=30, main="")
resi <- residuals(mod1, standardize=TRUE)
acf(resi^2, lag.max=30, main="")
```

![image-20221114121216820](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221114121216820.png)

![image-20221114121234592](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221114121234592.png)

Only have a single point slightly exceeds the boundary.

Finally, we use $ \hat \mu_t + 2\hat\sigma_t$ as 95% CI, connect each CI points as lines in t-axis direction, we get a figure:

![image-20221114122616250](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20221114122616250.png)

It can be seen that the values of logarithmic rate of return is almost in the prediction interval.

Or we can draw a conclusion that we get a proper model.