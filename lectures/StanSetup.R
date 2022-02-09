library(rstan)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))##set working directory to current file 


head(cars)
plot(cars$speed,cars$dist)



modeldata<-list(N=dim(cars)[1], x=cars$dist,y=cars$speed)

fit1<-stan(file='StanExample.stan',data=modeldata)
fit