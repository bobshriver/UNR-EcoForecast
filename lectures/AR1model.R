setwd(dirname(rstudioapi::getActiveDocumentContext()$path))##set working directory to current file 


data = read.csv('data/portal_timeseries.csv')
n<-length(data$NDVI)
#remove last 10
datafit<-data[1:(n-10),] ##

nfit<-length(datafit$NDVI)###Find length of shortened data frame
model<-glm(NDVI[-1]~NDVI[-(nfit)],data=datafit)###Fit glm, indexing removes the first and last years from reponse/explanatory
model

beta<-c(model$coefficients) #extract coefficients from fitted model. this will be used for forecast

#Forecasting function. I chose to nest the loop inside the function. But it would also work to make a loop and just a function solve for the values for a single year.
#yinit is the starting value, t is the number of years the forecast is for.
ARforecast<-function(b0,b1,yinit,t){
  yout<-numeric(t)
  yout[1]<-yinit
  for (i in 2:t){
    yout[i]<-b0+b1*yout[i-1]
    
  }
  return(yout)
  
}

Forecast1<-ARforecast(b0=beta[1],b1=beta[2],yinit=datafit$NDVI[nfit],t=11)

par(mfrow=c(2,1))
plot(1:11,Forecast1,ylab='NDVI',xlab='Month', type='l', ylim=c(0,.5))
points(data$NDVI[(n-10):n], col='red')




model2<-glm(NDVI[-1]~NDVI[-(nfit)]+rain[-(nfit)],data=datafit)
model2

raint_1<-data$rain[(n-10):(n-1)]
beta<-c(model2$coefficients)
ARforecastrain<-function(b0,b1,b2,yinit,t){
  yout<-numeric(t)
  yout[1]<-yinit
  for (i in 2:t){
    yout[i]<-b0+b1*yout[i-1]+b2*raint_1[i-1]
    
  }
  return(yout)
  
}

Forecast2<-ARforecastrain(b0=beta[1],b1=beta[2],b2=beta[3],yinit=datafit$NDVI[nfit],t=11)

plot(1:11,Forecast2,ylab='NDVI',xlab='Month', type='l',ylim=c(0,.5))
points(data$NDVI[(n-10):n], col='red')
