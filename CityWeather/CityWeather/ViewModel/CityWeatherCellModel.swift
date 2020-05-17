//
//  CityWeatherCellModel.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation

struct CityWeatherCellModel {
    var name: String
    var weatherDescription: String
    var minTem: String
    var maxTemp: String
    var windSpeed: String
    
    var isFetching: Bool
    var isValid: Bool?
}

extension CityWeatherCellModel {
    
    init(isFetching: Bool, isValid: Bool?) {
        self.init(name: "", weatherDescription: "",
                             minTem: "", maxTemp: "", windSpeed: "",
                             isFetching: isFetching, isValid: isValid)
    }
}
