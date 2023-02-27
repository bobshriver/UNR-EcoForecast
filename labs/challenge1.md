---
title: "Forecasting challenge #1"
output:
  html_document: default
layout: post
---

### Let the games begin ###

Do you think you are a good forecaster? A bad one? There is only one way to find out: a competition! We are going to try to forecast soil moisture in a desert grassland based on weather covariates. The idea is pretty simple: 

1. Pick your partner (1 group will have 3 people, the rest should have two), and sign up [here](https://docs.google.com/spreadsheets/d/1S56c6t4B002LyEM0VB-GBNOnMyfKnYxngniaBfSs9hM/edit?usp=sharing)
2. Each group downloads:
      + The [Soil moisture data](https://github.com/bobshriver/UNR-EcoForecast/blob/main/data/Forecasting1/2013_data.csv) from 2013.
      + [Daily weather covariates](https://github.com/bobshriver/UNR-EcoForecast/blob/main/data/Forecasting1/WeatherData.csv) that span the training data set and then continue for the forecast period.
3. Fit whatever kind of model you want, using any method you want, with the 2013 training data. You CANNOT use covariates from any other source. If you would like to fit a more complex Stan model with non-linearities or non-normal likelihoods I can help! I may not be able to help if you use another approach
4. Once you have finalized your model, you will generate a forecast for June 15 to October 15, 2014 (using the covariates for those days). Since we are hindcasting, the covariates are known.
5. Each group will also prepare a 5 minute presentation for the rest of the  class describing their model, and the choices they made to arrive at that model.
6. Submit your forecast by turning in your R script and a .csv file attachment containing your predictions on webcampus (see formatting instructions below).
7. I will evaluate forecast accuracy by comparing your predictions to the observed 
2014 values using RMSE and coverage (% of of observed points within 80% predictive interval)
8. The winning team for both RMSE and coverage will bask in eternal glory, and a cheap candy prize.

### Formatting ###

To make it easy for me to calculate the accuracy of your forecast,
please follow these formatting guidelines carefully. Create a data frame with four columns with the following names:
Day, Forecast, LowerPI, UpperPI.
The Day column should contain dates from 6/15/14 to 10/15/14 in mm/dd/yy format in order. 
The "Forecast" column contains your point (could be the mean or any other way of determining the most likely value) forecasts for each
day. The point forecasts should be in the original units! If you fit
on a transformed scale, please back transform. 

The last two (PI) columns report 80% predictive intervals. Again, these should be on the same scale as the observations.

Write your data frame to a .csv file using the following
line of code, substituting in the name of your data frame and the filename you want to use (your group name?):
```
write.csv(your_data_frame, your_file.csv, header=T)
```
Email the .csv file to Bob  as an attachment.

### Background ###

As we've discussed, mechanistic or system specific knowledge can design and improve forecasts. The soil moisture data come from the Jornada Basin, a desert grassland in south-central NM. 

Soil moisture data were collected hourly in units of volumetric water content using an in-situ soil moisture probe over 0-10cm soil depth. Hourly data was then averaged for a daily value. 

Weather data were from the [Jornada Basin LTER weather station](https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-jrn.210126001.118). This weather station is located about 250 meters from the location where soil moisture data were collected. Check the metadata or ask if you have any questions about the weather data. 

(Lab adapted from Peter Adler @ USU.)

