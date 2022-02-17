---
title: "Stan model fitting Pt. 3, Adding in Process Var."
output:
  html_document: default
layout: post
mathjax: true
---

*Please email all of your Stan and R code along with a document with answers to the following to Bob*



1) Add process variablity into the forecast we developed of mean NDVI last class and calculate 95% predictive intervals. Create a plot of the forecast timeseries with the overall mean and 95% credible intervals for the mean, 95% predictive intervals (process variability + parameter error), as well as the observed data.

2) How does the SD of the predictive interval change as we predict forward in time? Does uncertainty become larger or smaller or stay the same? Why?

3) How would our predictive intervals look different if we assumed there was no AR(1) term in the model (i.e. drop b1* from the model and run again)? Why is this different?

4) What is the amount of paramater error relative to process variability+paramater error in year 10 of the forecast in both the AR(1) model?

5) How would we expect the amount to paramater error relative to process variability to change as we collected more data?








