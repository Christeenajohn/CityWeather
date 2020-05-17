//
//  CWConstants.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation

struct APIConstants {
    static let appID                    = "5de2e9740f3737f139f9a6b147398798"
    static let rootURL                  = "https://api.openweathermap.org/data/2.5/"
    static let contentTypeJSON          = "application/json"
    static let contentTypeKey           = "Content-Type"
}

struct StoryBoardID {
    static let kCityWeatherController   = "cityWeatherVC"
}

struct CellIdentifiers {
    static let kWeatherDeatilsCell      = "weatherCell"
    static let kForecastDateCell        = "dateCell"
    static let kForeCastCell            = "forecastCell"
}

struct Alert {
    static let ok                       = "OK"
}

struct CWErrorMessages {
    static let defaultError             = "Something went wrong. Please try again"
    static let noInternerError          = "The internet connection appears to be offline"
    static let invalidCity              = "Please provide valid input. Valid input can contain 3 to 7 city names separated by comma."
    static let locationPermissionError  = "To show weather forecast for your city please enable location access for app from settings."
    static let cityNotFound             = "City not found."
}
