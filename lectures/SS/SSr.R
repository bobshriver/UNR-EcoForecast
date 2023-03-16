library(rstan)
library(shinystan)

N<-numeric(100)  #Storage for simulation

###Parameters###
a<-.1
b<-0.98


set.seed(1) ###make random draws repeatable


N[1]<-log(80) ##Set starting value


for (t in 2:100){ ###Simulate data assuming log-normal process error 
  
  N[t]<-a+b*N[t-1]+rnorm(1,0,.02)
  
}

plot(exp(N))

data<-rpois(length(N),exp(N)) ###Add sampling error as poisson (i.e. observation error)

###Withhold data###
datafit<-data[1:80]

###Fit stan model to simulated data###
modeldata<-list("y"=datafit, "T"=length(datafit))

options(mc.cores = parallel::detectCores())
fit1<-stan(file='StanSSPois.stan',data=modeldata, chains=3,iter=10000,control=list(adapt_delta=0.99))
###Divergences are a sign that the sampler isn't working quite right. There are a number of stan tutorials
###on how to fix this. We won't spend much time on it now, but moving the adaptdelta closer to 1 will help.

launch_shinystan(fit1)



####Generate Forecast
pars<-rstan::extract(fit1,c('a','b','sigma','n[80]') )
Nout<-matrix(NA,length(pars$a),21)

for(p in 1:length(pars$a)){
  Npred<-numeric(21)
  Npred[1]<-mean(pars$`n[80]`)###Starting value is out last inferred "true" population density
for (t in 2:21){
  
  
  Npred[t]<-pars$a[p]+pars$b[p]*Npred[t-1]+rnorm(1,0,pars$sigma[p])
  
}
  Nout[p,]<-exp(Npred)
  
}


###Compare forecast  to true density
MeanPred<-apply(Nout,2,mean)
UpperPred<-apply(Nout,2,quantile, prob=.975)
LowerPred<-apply(Nout,2,quantile, prob=.025)


plot(exp(N), ylim=c(80,200))
lines(80:100,MeanPred, col='red')
lines(80:100,UpperPred,lty=2, col='red')
lines(80:100,LowerPred,lty=2,  col='red')

#####

library(rstan)
library(shinystan)
N<-numeric(100)
a<-.1
b<-0.98
set.seed(1)
N[1]<-log(80)
for (t in 2:100){
  
  N[t]<-a+b*N[t-1]+rnorm(1,0,.02)
  
}

plot(exp(N))

data<-rnorm(length(N),exp(N),5)


###Withhold data###
datafit<-data[1:80]


modeldata<-list("y"=datafit, "T"=length(datafit))

options(mc.cores = parallel::detectCores())
fit1<-stan(file='StanSSNorm.stan',data=modeldata, chains=3,iter=10000)
launch_shinystan(fit1)




pars<-extract(fit1,c('a','b','sigma_p','n[80]') )
Nout<-matrix(NA,length(pars$a),21)

for(p in 1:length(pars$a)){
  Npred<-numeric(21)
  Npred[1]<-mean(pars$`n[80]`)
  for (t in 2:21){
    
    
    Npred[t]<-pars$a[p]+pars$b[p]*Npred[t-1]+rnorm(1,0,pars$sigma_p[p])
    
  }
  Nout[p,]<-exp(Npred)
  
}

MeanPred<-apply(Nout,2,mean)
UpperPred<-apply(Nout,2,quantile, prob=.975)
LowerPred<-apply(Nout,2,quantile, prob=.025)


plot(exp(N), ylim=c(80,200))
lines(80:100,MeanPred, col='red')
lines(80:100,UpperPred,lty=2, col='red')
lines(80:100,LowerPred,lty=2,  col='red')




