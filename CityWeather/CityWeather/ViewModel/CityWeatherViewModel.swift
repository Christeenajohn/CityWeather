//
//  CityWeatherViewModel.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation

class CityWeatherViewModel {
    private struct Constants {
        static let appID = "APPID"
        static let query = "q"
    }
    
    var cities: [String]! {
        didSet {
            for city in cities {
                cellViewModels[city] = CityWeatherCellModel(isFetching: false, isValid: nil)
            }
        }
    }
    
    private var cellViewModels = [String: CityWeatherCellModel]() {
        didSet {
            self.reloadTableClosure?()
        }
    }

    private var weatherData:[String: Weather] = [:]
        
    
    // MARK: Binding methods
    var reloadTableClosure: (()->())?
    
    
    // MARK: Class defenition
    private func fetchCurrentWeatherForCity(_ city: String) {
        
        getWeather(city: city) { [weak self, city] (result) in
              switch result {
              case .success(let weather):
                self?.weatherData[city] = weather
                self?.updateCellModels(weather, city: city)
                  
              case .failure(_):
                self?.cellViewModels[city] = CityWeatherCellModel(isFetching: false, isValid: false)
              }
          }
      }
    
    private func updateCellModels(_ weather: Weather, city: String)  {
        cityWeather[city] = weather
        cellViewModels[city] =  createCellViewModel(weather)
    }
    
    private func createCellViewModel(_ weather: Weather) -> CityWeatherCellModel {
        
        let maxTemp = String(format:"%f",  weather.main.temp_max )
        let minTemp = String(format:"%f",  weather.main.temp_min) 
           
        return CityWeatherCellModel(name: weather.name ,
                                    weatherDescription: weather.weather[0].type,
                                    minTem: minTemp,
                                    maxTemp: maxTemp,
                                    windSpeed: "\(weather.wind.speed)",
                                    isFetching: false,
                                    isValid: true)
     }

    
    // MARK: Public methods
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func configureCellViewModel(city: String) {
        if let model = cellViewModels[city],
            model.isValid == nil && model.isFetching == false {
            let cellModel = CityWeatherCellModel(isFetching: true, isValid: nil)
            cellViewModels[city] = cellModel
            fetchCurrentWeatherForCity(city)
        }
    }
    
    func getCellViewForCity(_ city: String) -> CityWeatherCellModel {
        guard let model = cellViewModels[city] else {
            return CityWeatherCellModel(isFetching: false, isValid: nil)
        }
        return model
    }
        
    
    // MARK: Network calls
    func getWeather(city: String,
                    completion: @escaping (Result<Weather, CWError>) -> Void) {
        // TODO - check caching for 10 min
//        if let weather = cityWeather[city] {
//            completion(.success(weather))
//        } else {
            let params = [Constants.appID: CWConstants.appID,
                          Constants.query: city]
            NetworkManager.request(route: WeatherAPIRouter.getWeather(params:params),
                                   completion: completion)
//        }        
      }
    
    
}
