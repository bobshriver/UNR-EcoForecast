---
title: "Time series decomposition and autocorrelation lab"
output:
  html_document: default
layout: post
mathjax: true
---

The purpose of this exercise is to practice loading a time series, then decomposing
it and testing for temporal autocorrelation. You can adapt the code that we
went over in class:

[Time series decomposition](https://github.com/bobshriver/UNR-EcoForecast/blob/main/lectures/decomp_tutorial.R)

[Autocorrelation](https://github.com/bobshriver/UNR-EcoForecast/blob/main/lectures/autocorrelation.R)

The first step is to download the data. We will work with climate data
from Tuscon, AZ, not too far from Portal. The data come from a gridded climate product called
[PRISM](http://www.prism.oregonstate.edu/explorer/)). You can get the .csv file [here](https://github.com/bobshriver/UNR-EcoForecast/blob/main/data/tucson_prism_monthly.csv).
Save it to your local drive (click on the "Raw" button then right-click and
"Save as"), then 1) read it into R using `read.csv()` and 2) 
convert the `tmin_C` column (minimum temperature) to a time series object. 
Now you are ready to answer the questions below.

*Each group should submit two files as attachments in webcampus to Bob,  an R script containing all the code you wrote, and a pdf/docx file with answers to the following questions. Each person needs to submit files, even if they are the same as your partner*

1) Decompose the time series using the `decompose()` function. Is there any clear
trend in the minimum temperature time series? What does the seasonal signal look
like? Would you get the same answer
just by calculating the monthly means? Answer with a figure(s) and a few 
sentences of explanation. (Are you curious if the same trend shows up for 
tmax? Let me know if you look into it.)

2) Create lag plots for the tmin data. Can you explain the circular patterns?


3) Is there autocorrelation? At what lags (in months)? Is there partial autocorrelation? At what lags? Include a figure(s) with an explanation.



