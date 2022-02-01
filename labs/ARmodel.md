---
title: "AR(1) model forecasting Pt. 1"
output:
  html_document: default
layout: post
mathjax: true
---

The purpose of this exercise is to fit a simple Gompertz model (AR(1) on the ln scale) and use it to forecast. We will be doing this using the Portal data that we used in last weeks lecture. Everyone should work in groups of two. 

*Each group should submit R script as attachments in an email to Bob*

Start by loading in the data. We are then going to drop the last ten measurements from the data, we will then and use the withheld data to test  forcasting (see below).

  `data = read.csv('./../data/portal_timeseries.csv')`
  
  `n<-length(data$rodents)`
  
  `#remove last 10`
  
  `datafit<-data[1:(n-10),] ##This is our "observed data`

1) Fit a Gompertz model to the rodents the observed data using the `lm` function. Remember that the Gompertz model is the AR(1) model if we take the natural log of the population size, so dont forget to `log` the population size first. (see example code below if you get stuck, but try it first and ask questions!!)

2) Create a function to forecast the population, and forecast the 10 months of the rodents data that we witheld, treating the last observed value as your initial condition. Plot the forecast for the next ten months along points for the withheld data.  This function will is very similar to logistic growth function we built in lab 1. You can extract the model parameters using `model$coefficients`. 

3) Repeat steps 1 & 2  using NDVI at t-1 along with population size at t-1 to explain population size at t.










Example code for step 1

`data = read.csv('./../data/portal_timeseries.csv')`

`n<-length(data$rodents)`

`#remove last 10`

`datafit<-data[1:(n-12),]`

`nfit<-length(datafit$rodents)`

`model<-glm(log(rodents[-1])~log(rodents[-(nfit)]),data=datafit)`

`model`


