n<-1000
j<-k<-0
y<-numeric(n)
while(k<n){
  u<-runif(1)
  j<-j+1
  x<-exp(u) #��g�в���һ�������
  if(x>u) {
    k<-k+1
    y[k]<-x
  }
}
#>j
#[1] 6153
