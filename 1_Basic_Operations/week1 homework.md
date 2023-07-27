# Week1 Homework 

**徐润奇 2220009454**

## Program 1.4.1 A flying start: Air passenger bookings

### code

```R
data(AirPassengers)
AP <- AirPassengers
AP
summary(AP)
class(AP)
start(AP); end(AP); frequency(AP)
plot(AP, ylab = "Passengers(1000's)")
layout(1:1)
plot(aggregate(AP))
layout(1:1)
boxplot(AP ~ cycle(AP))
```



### Detail

First of all data( AirPassengers ) is R's self-taking data. We give the value to variable AP, and print it :

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\1.png)

#### Summary ####

Then we use the command ***summary***(AP) to find some basic information about data, such as Mean, minimum and maximum value...

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\2.png)

#### class ####

Another  command is ***class*** , Which shows us the category of statistics. For example in this case, dataset is a time series, so it returns 'ts'.

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\3.png)

#### start,end,frequency ###

If we want to explore more about the time series, we can use commands start, end, frequency. ***start*** means the time of first observation, ***end*** means the time of last observation, ***frequency*** means the count of observation in the time period.

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\4.png)

#### plot,boxplot, ####

Now we want to do something with visualization. First of all we'd like to plot a figure to show the relationship between the time and passengers. Simply just need ***plot***(AP), and we use command ***'ylab=''*** to design the label.

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\5.jpg)

If we want to overview the distribution of data roughly, we may use ***boxplot***.  Recall the definition of boxplot:

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\10.jpg)

**Note** : $IQR$ means *Inter-Quartile Range*, $IQR=Q_3-Q_2$,That is, the span of two quartiles. 

For this program, the boxplot is :

```R
boxplot(AP ~ cycle(AP))
```



 ![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\11.jpg)

From the boxplot here we can describe that data is broadly concentrated, with Jun, July, August are distributer more dispersed relatively.

#### Aggregate ####

Sometime we need to do operation like 'Fold' or 'summary', command ***Aggregate*** satisfies the need properly. Let's see the performance of it. We define a variable *Agg*, with the code: *Agg<-aggregate(APP)*, we get:

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\6.jpg)

We can see each row becomes the summary of data for all the months.

Then we plot the figure, it shows:

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\7.jpg)

We try to find some further functions of the command *aggregate*.

First we define a data-frame:

```R
x <- data.frame(name = c('Arno','Jack','Lily','Amy'),
                sex = c('M','M','F','F'),
                age = c(20,30,40,50),
                height = c(177,180,155,160))
```

Hence we get a data-frame like this:

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\8.jpg)

Now we want to find the average number of age and height for each gender.

We use the code:

```R
#Find the everage age and height for different gender
y<-aggregate(x[,3:4],by=list(sex=x$sex),FUN = mean)
```

The result will be :

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\9.jpg)

#### cycle ####

Notice that through plotting boxplot, we have a row of code as:

```R
boxplot(AP ~ cycle(AP))
```

So what's the cycle means here and how to use it?

let's see how we get for $cycle(AP)$:

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\12.jpg)

For the official definition, $cycle$ gives the positions in the cycle of each observation. Hence, here we can match each month's Air-passengers data with the label 1,2,3...,then plot corresponding boxplot.

#### layout ####

$layout$ divides the device up into as many rows and columns as there are in matrix mat, with the column-widths and the row-heights specified in the respective arguments.

```R
#The code form is:
layout(mat, widths = rep.int(1, ncol(mat)),
       heights = rep.int(1, nrow(mat)), respect = FALSE)
layout.show(n = 1)
lcm(x)
```

The explanation of commands are:

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\13.jpg)



## Program 1.4.3 Multiple time series: Electricity, beer and chocolate data

### Code ###

```R
www <- "D:\\教学资料\\研究生\\时间序列\\data\\chapter1 CBE.txt"
CBE <- read.table(www, header = T)
CBE[1:4, ]
class(CBE)
Elec.ts <- ts(CBE[, 3], start = 1958, freq = 12)
Beer.ts <- ts(CBE[, 2], start = 1958, freq = 12)
Choc.ts <- ts(CBE[, 1], start = 1958, freq = 12)
plot(cbind(Elec.ts, Beer.ts, Choc.ts))
#the three series constitute a multiple time series

```

### Detail ###

#### ts function ####

In time series analysis we need to create some time series. So we need to use function $ts$.

Let's see the official usage:

```R
Usage
ts(data = NA, start = 1, end = numeric(), frequency = 1,
   deltat = 1, ts.eps = getOption("ts.eps"), class = , names = )
as.ts(x, ...)
is.ts(x)
```

With the arguments:

![](D:\教学资料\研究生\时间序列\Week1\Week1 homework\14.jpg)

We can see this case to gaather further understanding. Look at the code:

```R
Elec.ts <- ts(CBE[, 3], start = 1958, freq = 12)

```

$CBE[,3]$ means extract the 3-rd column of the table, which is Elec data

$start = 1958 $means the time series start from 1958, and tne $freq = 12$ means after 12 steps 1958 add 1, change into 1959. to be more specific in this case, it realize the function, to denote 12 months as 1 year, and present the data form month to year, what is needed.

#### bind ####

Sometimes we need to combine objects by Rows or Columns. Respectively, we use $rbind$ and $cbind$. 

Focus on code $cbind(Elec.ts, Beer.ts, Choc.ts))$, that combines 3 lists of data together as columns. we can plot it to further prove it:

![image-20220916130945452](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20220916130945452.png)

## Program 1.5.5 Decomposition in R

### Code ###

```R
#Decomposition of additive time series
Elec.decomadd <- decompose(Elec.ts)
plot(Elec.decomadd)
#Decomposition of multiplicative time series
Elec.decommult <- decompose(Elec.ts, type = "mult")
plot(Elec.decommult)
Trend <- Elec.decomadd$trend
Seasonal <- Elec.decomadd$seasonal
ts.plot(cbind(Trend, Trend + Seasonal), lty = 1:2)
#lty line type
```

### Detail ##

#### Decompose ####

$decompose()$ function is to input a time series, and decompose it into 4 terms as: **Trend, seasonal, random and cycle.**

With the code $decompose(Elec.ts)$, we can see the result:

 ![image-20220917155200656](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20220917155200656.png)

All the informations of decomposed time series are given.

**Note**: Decoposition of time series have two types, one is addictive, another is multiplicative. We use $'type'$ to order which one to operate:

```R
Elec.decommult <- decompose(Elec.ts, type = "mult")
```

Plot the 2-type figure:

![image-20220917161435536](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20220917161435536.png)

![image-20220917161450320](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20220917161450320.png)

#### ts.plot ####

 Let's see the introduction of **ts.plot** :

Plot several time series on a common plot. Unlike plot.ts the series can have a different time bases, but they should have the same frequency.

```R
ts.plot(cbind(Trend, Trend + Seasonal), lty = 1:2)
```

![image-20220917170659875](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20220917170659875.png)

This image shows the comparison of only trend and trend with seasonal effect.  *Note* : $'lty'$ means types of lines, in order to distinguish different figures.



## Page 24 1 ##

![image-20220917171438356](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20220917171438356.png)

#### Excercise a). ####

Since we already have *** chocolate.ts*** in the provious program.

```R
#Recall
 choc.ts <- ts(CBE[,1], start = 1958, freq = 12)
#Then we plot the data directly
plot(choc.ts)
```

![image-20220918112239209](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20220918112239209.png)

Then we use aggregate function to show the annual data:

```R
# Aggregate the annual series
Agg <- aggregate(Choc.ts)
plot(Agg)
```



![image-20220918112630687](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20220918112630687.png)

We can see through the annual data that the sales volumn is generally rising since 1960.

Then we try to find out more about the boxplot with the code:

```R
boxplot(Agg)
```

![image-20220918133401902](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20220918133401902.png)

We can do some comments on this boxplot. First obviously we can see the **median** is around 50000 a year. Then consider about the **skewness**. Because the median here is closer to the lower bound, so the data is a right-skewness distribution. There are two **outliers** above the maximum.

#### Excercise b) ####

Following code realize the decomopsition:

```R
# Decompose the data
choc.decom <- decompose(Choc.ts)
plot(choc.decom)
```

With the figure:

![image-20220919014850424](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20220919014850424.png)

Furthermore, we want to superimposed the seasonal impact on for the time series.

```R
# ts with superimposed seasonal effect
choc.trend <- choc.decom$trend
choc.seas <- choc.decom$seasonal
ts.plot(cbind(choc.trend,choc.trend + choc.seas), lty = 1:2)
```

With the result:

![image-20220919015603128](C:\Users\10306\AppData\Roaming\Typora\typora-user-images\image-20220919015603128.png)







 
