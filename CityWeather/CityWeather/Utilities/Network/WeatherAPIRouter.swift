//
//  WeatherAPIRouter.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation
import Alamofire

struct WeatherAPIs {
    static let currentWeather = "weather"
    static let forecast = "forecast"
}

enum WeatherAPIRouter: APIRouter {
    case getWeather(params: [String: String])
    case getForecast(params: [String: Any])
    
    
    var path: String {
        switch self {
        case .getWeather:
            return WeatherAPIs.currentWeather
        case .getForecast:
            return WeatherAPIs.forecast
        }
    }
    
    var requestURL: URL {
       return URL(string:CWConstants.rootURL + path)!
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.queryString
    } 
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: Parameters? {
        switch self {
        case .getWeather(let params):
            return params
        case .getForecast(let params):
            return params
        }
    }

}
