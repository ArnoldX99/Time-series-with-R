# We choose chocolate data for this ex
 plot(Choc.ts)
# Aggregate the annual series
Agg <- aggregate(Choc.ts)
plot(Agg)
boxplot(Agg)
# Decompose the data
choc.decom <- decompose(Choc.ts)
plot(choc.decom)
# ts with superimposed seasonal effect
choc.trend <- choc.decom$trend
choc.seas <- choc.decom$seasonal
ts.plot(cbind(choc.trend,choc.trend + choc.seas), lty = 1:2)

