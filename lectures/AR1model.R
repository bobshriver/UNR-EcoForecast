setwd(dirname(rstudioapi::getActiveDocumentContext()$path))##set working directory to current file 


data = read.csv('./../data/portal_timeseries.csv')
n<-length(data$NDVI)
#remove last 10
datafit<-data[0:(n-10),]
nfit<-length(datafit$NDVI)
model<-glm(NDVI[-1]~NDVI[-(nfit)],data=datafit)
model

beta<-c(model$coefficients)
ARforecast<-function(b0,b1,yinit,t){
  yout<-numeric(t)
  yout[1]<-yinit
  for (i in 2:t){
    yout[i]<-b0+b1*yout[i-1]
    
  }
  return(yout)
  
}

Forecast1<-ARforecast(b0=beta[1],b1=beta[2],yinit=datafit$NDVI[nfit],t=10)

par(mfrow=c(2,1))
plot(1:10,Forecast1,ylab='NDVI',xlab='Month', type='l', ylim=c(0,.5))
points(data$NDVI[(n-10):n], col='red')




model2<-glm(NDVI[-1]~NDVI[-(nfit)]+rain[-(nfit)],data=datafit)
model2

raint_1<-data$rain[(n-10):(n-1)]
beta<-c(model2$coefficients)
ARforecastrain<-function(b0,b1,b2,yinit,t){
  yout<-numeric(t)
  yout[1]<-yinit
  for (i in 2:t){
    yout[i]<-b0+b1*yout[i-1]+b2*raint_1[i]
    
  }
  return(yout)
  
}

Forecast2<-ARforecastrain(b0=beta[1],b1=beta[2],b2=beta[3],yinit=datafit$NDVI[nfit],t=10)

plot(1:10,Forecast2,ylab='NDVI',xlab='Month', type='l',ylim=c(0,.5))
points(data$NDVI[(n-10):n], col='red')
