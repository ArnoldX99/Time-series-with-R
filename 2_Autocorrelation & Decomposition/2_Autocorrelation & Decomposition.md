# Homework for week2

**徐润奇 ArnoldXu** xurunqi.arnold@gmail.com

## 2.2.5 Autocorrelation

```R
wave.dat <- "D:\\data\\chapter2 wave.dat.txt"
wave <- read.table(wave.dat, header = TRUE)
attach(wave)
ts.plot(waveht) 
plot(ts(waveht[1:60]))
#the lag 1 autocorrelation for waveht
acf_1 <- acf(waveht)$acf
acf_2 <- acf(waveht)$acf[2]
plot(waveht[1:396],waveht[2:397])
```

### Function attach()

Sometimes we may use **attach()** function to search the data from a data-frame if we use it frequently.

Let's take an example:

```R
# Clear the working environment
rm(list=ls(all=TRUE))
# Define a dataframe
(Data <- data.frame(a = 1:5, b = 6:10))
  a  b
1 1  6
2 2  7
3 3  8
4 4  9
5 5 10
# Define variables out of dataframe 
> (a <- 11:15)
[1] 11 12 13 14 15
> (c <- 16:20)
[1] 16 17 18 19 20
```

Here we created a special situation: Inside matrix Data we have a list $a$ , but we also define a variable $a$ outside in the global environment. So what should we do to search these 2 'a' if we want to use them?

First we want to search $b$: 

```r
> b
Error: Cannot find the object 'b'
```

We can see we cannot find object b directly if it's inside a data-frame.

Then we applying $attach(data)$:

```R
> attach(Data)
The following object is masked _by_ .GlobalEnv:
    a
> a
[1] 11 12 13 14 15
> b
[1]  6  7  8  9 10
```

Here we can see: after $attach()$ , we can find variable $b$ directly.

But for our 'special' $a$, it has 2 'status'. We can see the **priority**  of recall $a$ is global environment. If we want to use $a$ inside the data-frame., we shall use $data(a)$:

```R
# Comparison
> a
[1] 11 12 13 14 15
> Data$a
[1] 1 2 3 4 5
```

And we can use $detach()$ to turn back original situation.

***Warning ! ! !*** :

 We may meet some troubles here:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/83b0af33-3589-4384-b7e5-8a31a24a4880)


Even if we could run the code and give out the result,  the default won't disappear.

The help page for `attach()` notes that *attach can lead to confusion*. The [Google R Style Manual](https://links.jianshu.com/go?to=https%3A%2F%2Fgoogle-styleguide.googlecode.com%2Fsvn%2Ftrunk%2Fgoogle-r-style.html%23attach) provides clear advice on this point, providing the following advice about `attach()`: *The possibilities for creating errors when using attach are numerous. Avoid it*

By applying $attach()$ , then we plot the variable $waveht$:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/7bfff830-041f-4d45-afca-215d0b58c40e)

#### Function acf()

Function $acf()$ is used to find the autocorrrelation for our data.

$acf()$ is defined as :

```R
acf(x,type=c("correlation","covariance","partial"),lag.max=n)
```

$x$ is the input data, $type$ is the type of autocorrelations. $lag.x$ 

Define a variable $acf_1$, such that: The maximum lag order, n determines the length of abscissa in acf graph.

```R
acf_1 <- acf(waveht)$acf
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/d677efd4-cf63-4ff6-9257-77d0a9c1207b)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/1ce3439f-9087-4c93-b324-93ea6b8c2b7c)

Since nearly excpect around origin, nearly all the bars lies inside the blue line, it means no obvious correlation for this group of data.

By the way, we can use the command:

```R
acf_2 <- acf(waveht)$acf[2]
# output will be 0.47
```

To check each term in the time series.

#### lagn scatterplot

If we want to find the autocorrelation directly by figure, we can

```R
plot(waveht[1:396],waveht[2:397])
```

The figure shows the raltion between a term with next term.

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/223587c5-2cb9-4835-95ca-7c4a699c9c9c)

We can see roughly it has no obvious autocorrelation.

## 2.3.2 examples based on air passenger series

```R
acf(AirPassengers)
data(AirPassengers)
AP <- AirPassengers
AP.decom <- decompose(AP, "multiplicative")
class(AP.decom$random[7:138])
length(AP)
plot(ts(c))
acf(AP.decom$random[7:138])
sd(AP[7:138])
sd(AP[7:138] - AP.decom$trend[7:138])
sd(AP.decom$random[7:138])
```

First of all we draw a acf figure of data:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/9d407105-ca7f-42b4-9f7f-4b7d63a1e005)

We can see here is a strong effect of autocorrelations.

Compare data AP wtih AP eliminated trend:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/a9cc0454-168e-42c4-8e7e-194ed0457f35)

We can see after substract the trend, standard diviation cut down obviouly.

## Page 42.2 Vineyard

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/97b2eacd-952c-4738-a88a-55117bee5dcb)

```R
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
```

First we input the data, save the data from 2 different vinyards as $ssv$ and $ccv$.

Plot the figure by using command ts.plot, we get:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/224d0d7e-6b6b-408a-ae9d-cba462f1a351)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/4ca3a27f-0004-448c-a4ca-c521111dfbf0)

For each time series, we draw a scatter plot as below:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/4e6b5d06-6f46-484f-9d60-bf0c159aaa49)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/15ad064a-5f5a-4ccb-8a34-dad91fd619d7)

Produce the $acf$ for both time series we get :

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/2c3bcc03-4e7e-4cce-92f0-d38cdefe5662)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/70cd6cb6-9764-47a1-8510-08841a378833)

We can see both for SSV and CCV, we have no obvious autocorrelation for them.

## Page 42.3 global temperature

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/18d39eb1-ab14-4b1d-b338-1b56508b74b1)

```R
www <- "D://data//chapter1 global.txt"
global <- scan(www)
global.ts <- ts(global, st = c(1856, 1), end = c(2005, 12),fr = 12)
# Decompose the series
global.decom= decompose(global.ts)
plot(global.decom)

#Produce a plot of the trend with a superimposed seasonal effect.
global.deseasonal <- global.ts - global.decom$seasonal
ts.plot(cbind(global.deseasonal,global.deseasonal+global.ts),lty =1:2)

#Compare the standard deviation of the original series with the deseasonalised series
sd(global.ts)
sd(global.deseasonal)


#Plot the correlogram of the residuals (random component) 
global.random <- global.decom$random
acf_random <- acf(global.random,na.action = na.pass)$acf
```

First of all for this question we decompose the data, it give us the figure:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/b6f3859e-c3cb-4e24-b25f-6300345f4d0c)

We can see after eliminating the random, seasonal, trend effect, the trend of temperature is rising in a steady pace.

As we expect, this series of data will be effectted by the seasonal effects.

Compare the standard deviation of the original series with the deseasonalised series, we get:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/3693495a-b943-405e-8646-1b9f8558d223)

It obviously has difference for deviation.

Then we produce a plot of the trend with a superimposed seasonal effect:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/774432ac-07e9-47ed-8002-ba3b2eab93fb)

  We use acf function to plot the correlogram of the residuals (random component) :

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/569c9bd9-dffc-4107-8602-f8b8920e6ebb)

We can see here still has periodicity in the random terms. Hence we need to find out more to eliminate it.  

### 42.5 

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/17f1b7ad-d888-40e9-a069-c14983b06d82)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/be002cb5-d1e2-441b-b2a5-b2b99b6d40ba)

***proof***  ![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/d2e23473-19f8-448e-babb-db20d2c91d97)

