# 3_Holtwinters_model

## complains to a motoring organization

```R
#complains to a motoring organization
www <- "D:\\data\\chapter3 motororg.dat.txt"
Motor.dat <- read.table(www, header = T)
attach(Motor.dat)
Comp.ts <- ts(complaints, start = 1996, 1, freq = 12)
plot(Comp.ts, xlab = "Time / months", ylab = "Complaints")

Comp.hw1 <- HoltWinters(complaints, beta = F, gamma = F) 
Comp.hw1
plot(Comp.hw1)
Comp.hw1$SSE
#alpha = 0.2
Comp.hw2 <- HoltWinters(complaints, alpha = 0.2, beta=F, gamma=F)
plot(Comp.hw2)
Comp.hw2$SSE
```

This example uses the Holt-Winters method for the prediction of the time series. First we input the dataset, use 'attach' to read a list of variables 'complains'.

First of all let's see the visualization of the time series:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/1731ee7f-0d47-4c6b-b056-ae96d3d9d941)

We can see obviously here is a seasonal effect. Then we want to use Holt-Winters method to predict the trend by the code:

```R
Comp.hw1 <- HoltWinters(complaints, beta = F, gamma = F) 
```

With the result visualized:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/a528a1ac-4954-4730-8f34-fadf38469b66)

With the coefficients and $SSE$ :

```R
Smoothing parameters:
 alpha: 0.1429622
 beta : FALSE
 gamma: FALSE

Coefficients:
      [,1]
a 17.70343
```

 We can see if we don't input the coefficients, it will give us the best fitted one with the least sum of errors.

Compare with coefficient $\alpha=2$ defined by us, we can see:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/65ea0b08-be6d-4fef-a1b7-8bfffaccfda3)

With the $SSE=2526.9 > 2502.028$.

 So it's a convenient way for us to use function give us automatically coefficients.

## Sales of Australian wine

```R
#sales of australian wine
www <- "D:\\data\\chapter3 wine.dat.txt"
wine.dat <- read.table(www, header = T) ; 
attach (wine.dat)
sweetw.ts <- ts(sweetw, start = 1980, freq = 12)
plot(sweetw.ts, xlab= "Time (months)", ylab = "sales (1000 litres)")
sweetw.decom<-decompose(sweetw.ts,type="mult")
plot(sweetw.decom)
sweetw.hw <- HoltWinters (sweetw.ts, seasonal = "mult")
sweetw.hw ; sweetw.hw$coef ; sweetw.hw$SSE
sqrt(sweetw.hw$SSE/length(sweetw))
sd(sweetw)
plot (sweetw.hw$fitted)
plot (sweetw.hw)
```

This example helps us to get a further understanding of the function Holt-winters.

Well let's see how the Holt-Winters operate by the figure:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/bbb719a3-bd3f-4e7a-b2ba-b07ac66a7b9f)

We can see the trend term turns to stationary. With the Holt-Winters fitted figure:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/2c074f04-967f-4dd5-b262-cf953f98b82c)

 It seems by using Holt-Winters filtering we get a good result. Let's check scientifically with $MSE$, we get MSE = 50.54219, quite small and proper.

## Four year ahead forecasts for the air passenger data

```R
#four year ahead forecasts for the air passenger data
data(AirPassengers)
AP <- AirPassengers
AP.hw <- HoltWinters(AP, seasonal = "mult")
plot(AP.hw)
AP.predict <- predict(AP.hw, n.ahead = 4 * 12)
ts.plot(AP, AP.predict, lty = 1:2)
```

This case tells us how to do a further prediction of Holt-Winters methods. Focus on the code :

```R
AP.predict <- predict(AP.hw, n.ahead = 4 * 12)
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/84fe92e8-3877-44dc-b395-67d5173b18bc)

We use $predict$ function here. Input the dataset first, then use  $n.ahead$  command, $4*12$ here means, 4 years, 12 months per year.

## 5. c),d)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/ffd3160c-5f13-4de1-9220-e47463e4459a)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/4927ddb5-d6b1-4a48-b0e4-474289124c8b)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/4266ffc2-47ba-4022-86e0-0f049447e73e)

## 7. b),c),d) 

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/e3880b60-316f-46a7-95f5-10d1ac01251a)

```R
www <- 'D://data//chapter1 global.txt'
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
```



### (b) Decomposed

First we print out the decomposition of additive time series.

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/710a3dcd-753e-47f8-9d86-213ac40922d1)

We can see it has an obvious seasonal trend. Then we plot the trend with superimposed seasonal effect below:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/73dc0a57-c6df-4edb-8544-767857422547)

### （c) Correlogram

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/3ddff110-bc54-450a-b8a9-e717e814b8ee)

We can find the Periodicity in the figure. 

### (d) Holt-Winters model

There are 2 choice for us ： Multiplicative and additive. We try to make a comparison:

* multiplicative

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/e70f04ba-3468-4c5a-8962-184a50abedc6)

* additive 

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/8d73f2dd-d0a0-42b2-962f-5eef799ab3c2)

Obviously we can see additive case is more proper. We can also use MSE to help us make a decision:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/6a380b7c-3c94-4e34-a65a-6f63dd1d85f9)

The error of additive is much less than multiplicative one. So we choose additive.

And finally we print out the coefficients:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/ff93057c-83ac-4c0c-97c3-15d61ce9513f)

