library(rstan)
library(shinystan)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))##set working directory to current file 


head(cars)
plot(cars$speed,cars$dist)


#####A list is needed to declare the data that goes into the model. 
#####The things listed here should match the data block
modeldata<-list(N=dim(cars)[1], x=cars$dist,y=cars$speed)

###Stan fit the model using a monte carlo algorithm. You can essentially think of this as a sophisticated guess and check.
###The end result is a vector of parameters that make up the posterior distrbution.
###This code runs the stan model. It will first compile the code and then run through all of the chains sequentially
###There are a number of parameters you can adjust, chain lengths, number of chains. 
fit1<-stan(file='StanExample.stan',data=modeldata, chains=3,iter=300, warmup=10)
fit1

###The extract function can used to extract the parameter value draw from the chains. 
###The parameters you want to extract need to be specified. 
pars<-extract(fit1, c('b0','b1','sigma'))

#Notice how long the parameter is # of chains*(Total iterations-warmup)
length(pars$b0)

###Plots of the posterior 
par(mfrow=c(2,2))
hist(pars$b0)
hist(pars$b1)
hist(pars$sigma)


##visualizations to check convergence. Have chains converged? 
launch_shinystan(fit1)












