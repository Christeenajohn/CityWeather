//
//  Forecast.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation

struct Forecast: Codable {
     var city: City
     var list: [ForecastData]
}

struct ForecastData: Codable  {
    var dt_txt: String
    var wind: WindData
    var weather: [WeatherData]
    var main: MainData
}

struct City: Codable {
    var name: String
    var country: String
}


