n<-1000
j<-k<-0
y<-numeric(n)
while(k<n){
  u<-runif(1)
  j<-j+1
  x<-exp(u) #从g中产生一个随机数
  if(x>u) {
    k<-k+1
    y[k]<-x
  }
}
#>j
#[1] 6153
