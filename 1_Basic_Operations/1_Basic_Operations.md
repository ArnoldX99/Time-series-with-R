# 1_Basic_Operations


**徐润奇 ArnoldXu** xurunqi.arnold@gmail.com

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
![1](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/44f9b5bb-c333-4e5e-abdb-b074a588ab29)


#### Summary ####

Then we use the command ***summary***(AP) to find some basic information about data, such as Mean, minimum and maximum value...
![2](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/61e897eb-4bca-4854-ab1c-05366582822a)


#### class ####

Another  command is ***class*** , Which shows us the category of statistics. For example in this case, dataset is a time series, so it returns 'ts'.
![3](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/60836645-2097-492b-8ad2-1e8bf7b6e8d0)


#### start,end,frequency ###

If we want to explore more about the time series, we can use commands start, end, frequency. ***start*** means the time of first observation, ***end*** means the time of last observation, ***frequency*** means the count of observation in the time period.
![4](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/a7ca3d02-0bd5-41e2-8db0-e2f6e792eadc)



#### plot,boxplot, ####

Now we want to do something with visualization. First of all we'd like to plot a figure to show the relationship between the time and passengers. Simply just need ***plot***(AP), and we use command ***'ylab=''*** to design the label.
![5](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/d0889297-fa3b-4ff4-9008-296fe416a628)



If we want to overview the distribution of data roughly, we may use ***boxplot***.  Recall the definition of boxplot:
![10](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/2ae8429c-bd6b-43ec-9f70-fb5e2adc3588)



**Note** : $IQR$ means *Inter-Quartile Range*, $IQR=Q_3-Q_2$,That is, the span of two quartiles. 

For this program, the boxplot is :

```R
boxplot(AP ~ cycle(AP))
```

![11](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/b13e0b5b-f139-42bd-b211-0ce0aba7fc24)


From the boxplot here we can describe that data is broadly concentrated, with Jun, July, August are distributer more dispersed relatively.

#### Aggregate ####

Sometime we need to do operation like 'Fold' or 'summary', command ***Aggregate*** satisfies the need properly. Let's see the performance of it. We define a variable *Agg*, with the code: *Agg<-aggregate(APP)*, we get:
![6](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/38995b6d-1541-48a0-9da1-7b34ca874556)



We can see each row becomes the summary of data for all the months.

Then we plot the figure, it shows:
![7](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/956aaa1a-9adb-49f7-9311-31d17bb35f88)



We try to find some further functions of the command *aggregate*.

First we define a data-frame:

```R
x <- data.frame(name = c('Arno','Jack','Lily','Amy'),
                sex = c('M','M','F','F'),
                age = c(20,30,40,50),
                height = c(177,180,155,160))
```

Hence we get a data-frame like this:
![8](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/2b5307f7-63f4-4660-bdff-53c02be8ccba)



Now we want to find the average number of age and height for each gender.

We use the code:

```R
#Find the everage age and height for different gender
y<-aggregate(x[,3:4],by=list(sex=x$sex),FUN = mean)
```

The result will be :
![9](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/a0d3a2ab-3506-441d-a0db-b3f6efb0bca9)



#### cycle ####

Notice that through plotting boxplot, we have a row of code as:

```R
boxplot(AP ~ cycle(AP))
```

So what's the cycle means here and how to use it?

let's see how we get for $cycle(AP)$:
![12](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/3ff56175-d68e-42f5-82a9-a6bd1de8db36)


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

![13](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/35d66455-f98c-42b0-a4f3-2cb12ab22ac2)



## Program 1.4.3 Multiple time series: Electricity, beer and chocolate data

### Code ###

```R
www <- "D:\\data\\chapter1 CBE.txt"
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
![14](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/a8929abb-6d32-4a49-bb7d-d106c36be1c5)


We can see this case to gaather further understanding. Look at the code:

```R
Elec.ts <- ts(CBE[, 3], start = 1958, freq = 12)

```

$CBE[,3]$ means extract the 3-rd column of the table, which is Elec data

$start = 1958 $means the time series start from 1958, and tne $freq = 12$ means after 12 steps 1958 add 1, change into 1959. to be more specific in this case, it realize the function, to denote 12 months as 1 year, and present the data form month to year, what is needed.

#### bind ####

Sometimes we need to combine objects by Rows or Columns. Respectively, we use $rbind$ and $cbind$. 

Focus on code $cbind(Elec.ts, Beer.ts, Choc.ts))$, that combines 3 lists of data together as columns. we can plot it to further prove it:
![15](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/bf353f51-410f-4de8-b80e-82abf435f620)


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

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/600137a4-8e80-4ff1-8fa1-2287e47fd97e)

All the informations of decomposed time series are given.

**Note**: Decoposition of time series have two types, one is addictive, another is multiplicative. We use $'type'$ to order which one to operate:

```R
Elec.decommult <- decompose(Elec.ts, type = "mult")
```

Plot the 2-type figure:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/38a0361a-ce7a-4e3f-8557-443d507d8899)

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/b15c0e08-915c-49df-9585-5e5055ca3f5b)

#### ts.plot ####

 Let's see the introduction of **ts.plot** :

Plot several time series on a common plot. Unlike plot.ts the series can have a different time bases, but they should have the same frequency.

```R
ts.plot(cbind(Trend, Trend + Seasonal), lty = 1:2)
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/e32f9af6-5148-4c16-89fa-15b38d05f998)

This image shows the comparison of only trend and trend with seasonal effect.  *Note* : $'lty'$ means types of lines, in order to distinguish different figures.



## Page 24 1 ##

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/307c1929-f91b-4dc5-a048-37fe96614836)

#### Excercise a). ####

Since we already have *** chocolate.ts*** in the provious program.

```R
#Recall
 choc.ts <- ts(CBE[,1], start = 1958, freq = 12)
#Then we plot the data directly
plot(choc.ts)
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/04fb6411-8763-46d0-a8e3-d694cd1b3ac4)

Then we use aggregate function to show the annual data:

```R
# Aggregate the annual series
Agg <- aggregate(Choc.ts)
plot(Agg)
```



![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/d59d8f96-9e2c-4129-99c2-9dc225b63fad)

We can see through the annual data that the sales volumn is generally rising since 1960.

Then we try to find out more about the boxplot with the code:

```R
boxplot(Agg)
```

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/45ecfadc-c65a-4c68-967a-66c925f2a4e5)

We can do some comments on this boxplot. First obviously we can see the **median** is around 50000 a year. Then consider about the **skewness**. Because the median here is closer to the lower bound, so the data is a right-skewness distribution. There are two **outliers** above the maximum.

#### Excercise b) ####

Following code realize the decomopsition:

```R
# Decompose the data
choc.decom <- decompose(Choc.ts)
plot(choc.decom)
```

With the figure:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/42caa452-ff45-412d-8ed8-2477401301c5)

Furthermore, we want to superimposed the seasonal impact on for the time series.

```R
# ts with superimposed seasonal effect
choc.trend <- choc.decom$trend
choc.seas <- choc.decom$seasonal
ts.plot(cbind(choc.trend,choc.trend + choc.seas), lty = 1:2)
```

With the result:

![image](https://github.com/ArnoldX99/Time-series-with-R/assets/64125777/5f2e0012-d6ab-473b-be32-cc0f5c5de41c)







 
