---
title: "AR(1) model forecasting Pt. 1"
output:
  html_document: default
layout: post
mathjax: true
---

The purpose of this exercise is to fit a simple AR(1) and use it to forecast. We will be doing this using the Portal NDVI data that we used in last weeks lecture. Everyone should work in groups of two. 

*Each individual should submit R script on WebCampus*

Start by loading in the data. We are then going to drop the last ten measurements from the data, we will then and use the withheld data to test  forcasting (see below).

  `data = read.csv('./../data/portal_timeseries.csv')`
  
  `n<-length(data$NDVI)`
  
  `#remove last 10`
  
  `datafit<-data[1:(n-10),] ##This is our "observed data`

1) Fit a AR(1) model to the NDVI observed data using the `lm` function. You will need to use indexing to match up NDVI at t with NDVI at t-1. (see example code below if you get stuck, but try it first and ask questions!!).

2) Create a function to forecast the NDVI, and forecast the 10 months of the NDVI data that we witheld, treating the last observed value as your initial condition. Plot the forecast for the next ten months along points for the withheld data.  This function will is very similar to logistic growth function we built in lab 1. You can extract the model parameters using `model$coefficients`. 

3) Repeat steps 1 & 2  using rain at t-1 along with NDVI at t-1 to explain NDVI at t.










Example code for step 1

`data = read.csv('./../data/portal_timeseries.csv')`

`n<-length(data$NDVI)`

`#remove last 10`

`datafit<-data[1:(n-10),]`

`nfit<-length(datafit$NDVI)`

`model<-glm(NDVI[-1]~NDVI[-(nfit)],data=datafit)`

`model`


