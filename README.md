# iOS City Weather App



## Overview

Using 'City Weather App' you can find 
  - Current Weather of multiple cities (min 3 cities and max 7) 
  - Weather forecast of your current city in 3 hour format for next 5 days.

This project is following MVVM architecture.
Closures are used as binding technique to update Views as per ViewModels.
'Openweathermap' APIs are used to find the weather data.

### User Guide

To fetch Current weather of multiple cities 
 - Launch the app
 - Give the city names (separated with coma) in the home screen and search
 - New screen will open with the weather details
 - To see next citi's weather swipe right.
 
To get 5 days forecast
 - Launch the app
 - Navigate to 'Forecast' tab
 - Give location permission to the app
 - Now you can see the forecast for next 5 days


## How To

### Run The App

- Download the project or clone the git repository to your device
- Open CityWeather.xcworkspace in Xcode
- Select the 'Project navigator' and select project file
- Open Signing&Capabilities tab and select your team / personal team
- Update bundle id if required and make it compatible with team
- Select the device / simulator you wish to run
- Product -> Run


### Run Test Cases

- Test cases are written inside CityWeatherTests folder
- Product -> Test 


### Get Code Coverage Report

- Open Report navigator from Navigator panel
- Now run the test once more
- Once its run and finish all the test cases you can see the code coverage report.

