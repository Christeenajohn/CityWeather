//
//  CWConstants.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation

struct StoryBoardID {
    static let kCityWeatherController = "cityWeatherVC"
}

struct ErrorMessages {
    static let invalidCity = "Please provide valid input. Valid input can contain from 3 cities to 7 cities comma separated"
    static let locationPermissionError = "To show weather forecast for your city please enable location access for app from settings."
}

struct CellIdentifiers {
    static let kWeatherDeatilsCell  = "weatherCell"
    static let kForecastDateCell    = "dateCell"
    static let kForeCastCell        = "forecastCell"
}
