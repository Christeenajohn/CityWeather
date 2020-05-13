//
//  Weather.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation

struct Weather: Codable {
     var weather: [WeatherData]
     var main: MainData
    var wind: WindData
    var name: String
}

struct WeatherData: Codable  {
    var type: String
    
    private enum RootKeys: String, CodingKey {
        case type = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
    }
}

struct MainData: Codable {
    var temp_min: Double
    var temp_max: Double
}

struct WindData: Codable {
    var speed: Double
}
