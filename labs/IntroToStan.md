---
title: "Stan model fitting Pt. 1"
output:
  html_document: default
layout: post
mathjax: true
---

The purpose of this exercise is familiarize yourself with Stan by fitting the same AR(1) model we did with the `lm `function. 

*Turn in document with your reponses to these questions and figures. There is no need to turn in this code yet, we will build off of it in the next lab*

Start by loading in the data. We are then going to drop the last ten measurements from the data, we will then and use the withheld data to test forecasting in next lab.

  `data = read.csv('./../data/portal_timeseries.csv')`
  
  `n<-length(data$NDVI)`
  
  `#remove last 10`
  
  `datafit<-data[1:(n-10),] ##This is our "observed data`

1) Fit a AR(1) model to the NDVI observed data, including rain as a covariate, using Stan. Try both having the response variable and covariates as a vector as well as in a `for` loop.

3) Create histograms for all parameter posterior distributions (b0,b1,b2,sigma).

2) How do the mean parameter estimates differ from the `lm` model?









