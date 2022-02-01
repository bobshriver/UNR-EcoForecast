setwd(dirname(rstudioapi::getActiveDocumentContext()$path))##set working directory to current file 


data = read.csv('./../data/portal_timeseries.csv')
n<-length(data$NDVI)
#remove last 10
datafit<-data[0:(n-12),]
nfit<-length(datafit$NDVI)
arfit<-glm(NDVI[-1]~NDVI[-(nfit)],data=datafit)


beta<-c(arfit$coefficients)
sigma(arfit)
