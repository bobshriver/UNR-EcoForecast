library(rstan)
library(shinystan)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))##set working directory to current file 


data = read.csv('./../data/portal_timeseries.csv')

n<-length(data$NDVI)

#remove last 10

datafit<-data[1:(n-10),] ##This is our "observed data




#####A list is needed to declare the data that goes into the model. 
#####The things listed here should match the data block
modeldata<-list(N=dim(datafit)[1], y=datafit$NDVI,rain=datafit$rain)

###Stan fit the model using a monte carlo algorithm. You can essentially think of this as a sophisticated guess and check.
###The end result is a vector of parameters that make up the posterior distrbution.
###This code runs the stan model. It will first compile the code and then run through all of the chains sequentially
###There are a number of parameters you can adjust, chain lengths, number of chains. 
fit1<-stan(file='StanExample_Portal.stan',data=modeldata, chains=3,iter=2000, warmup=1000)
fit1

###The extract function can used to extract the parameter value draw from the chains. 
###The parameters you want to extract need to be specified. 
pars<-rstan::extract(fit1, c('b0','b1','b2','sigma'))

#Notice how long the parameter is # of chains*(Total iterations-warmup)
length(pars$b0)

###Plots of the posterior 
par(mfrow=c(2,2))
hist(pars$b0)
hist(pars$b1)
hist(pars$b2)
hist(pars$sigma)


##visualizations to check convergence. Have chains converged? 
#launch_shinystan(fit1)

PredData<-data[(n-10):n,]
PredOut<-matrix(NA,length(pars$b0),10)

for (p in 1:length(pars$b0)){
  NDVI<-PredData$NDVI[1]
  for(t in 1:10){
     NDVI<- rnorm(1,mean=pars$b0[p]+1*NDVI+pars$b2[p]*PredData$rain[t],sd=pars$sigma[p])
  PredOut[p,t]<-NDVI
  }
  
  
}

#hist(PredOut[,1])

matplot(t(PredOut),type='l')

MeanP<-apply(PredOut,2,mean)
Upper<-apply(PredOut,2,quantile, prob=.975)
Lower<-apply(PredOut,2,quantile, prob=.025)
  
  
plot(MeanP,type='l', ylim=c(0,.4)) 
lines(Upper,lty=2)
lines(Lower,lty=2)  
points(PredData$NDVI,col='steelblue')

###obs error

PredData<-data[(n-10):n,]
PredOut<-matrix(NA,length(pars$b0),10)

for (p in 1:length(pars$b0)){
  NDVI<-PredData$NDVI[1]
  for(t in 1:10){
    NDVI<- pars$b0[p]+pars$b1[p]*NDVI+pars$b2[p]*PredData$rain[t]
    PredOut[p,t]<-rnorm(1,mean=NDVI,sd=pars$sigma[p])
  }
  
  
}

#hist(PredOut[,1])

matplot(t(PredOut),type='l')

MeanP<-apply(PredOut,2,mean)
Upper<-apply(PredOut,2,quantile, prob=.975)
Lower<-apply(PredOut,2,quantile, prob=.025)


plot(MeanP,type='l', ylim=c(0,.4)) 
lines(Upper,lty=2)
lines(Lower,lty=2)  
points(PredData$NDVI,col='steelblue')

