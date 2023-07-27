x <- data.frame(name = c('Arno','Jack','Lily','Amy'),
                sex = c('M','M','F','F'),
                age = c(20,30,40,50),
                height = c(177,180,155,160))
#Find the everage age and height for different gender
y<-aggregate(x[,3:4],by=list(sex=x$sex),FUN = mean)