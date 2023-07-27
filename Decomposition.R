#1.5.5 Decomposition in R
Elec.decomadd <- decompose(Elec.ts)
plot(Elec.decomadd)
Elec.decommult <- decompose(Elec.ts, type = "mult")
plot(Elec.decommult)
Trend <- Elec.decomadd$trend
Seasonal <- Elec.decomadd$seasonal
ts.plot(cbind(Trend, Trend * Seasonal), lty = 1:2)
#lty line type
