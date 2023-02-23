---
title: "Stan model fitting Pt. 3, Adding in Process Var."
output:
  html_document: default
layout: post
mathjax: true
---

*Please turn in your R code along with a document with answers to the following to Bob*



1) Add process variablity into the forecast we developed of mean NDVI last class and calculate 95% predictive intervals. Create a plot of the forecast timeseries with the overall mean and 95% credible intervals for the mean, 95% predictive intervals (process variability + parameter error), as well as the observed data. How many points fall outside the full predictive interval? How many might we expect given that we are forecasting 10 years with a 95% interval?

2) How would our predictive intervals look different if we assumed the model did not have a long-term equilibium? Try this out by replacing b1 with 1 in your forecast code and rerunning your forecast in question 1. Why is this different from the results of question 1?

3) How would we expect the amount to paramater error relative to process variability to change as we collected more data?

4) Now assume $\sigma$ represents observation uncertainty, rather then process uncertainty. How does this change the predictive intervals from question 2, and why? Try it out if you are not sure. 








