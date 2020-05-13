//
//  ForecastViewModel.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation
import CoreLocation


class ForecastViewModel: NSObject {
    private struct Constants {
        static let appID = "APPID"
        static let lat = "lat"
        static let lon = "lon"
    }
    
    private let locationManager = CLLocationManager()
    var currentCordinates : CLLocationCoordinate2D? {
        didSet {
            updateForecast()
        }
    }
    
    private var city: String? {
        didSet {
            updateCurrentLocation?(city)
        }
    }
    
    private var isFetching: Bool = false {
        didSet {
            updateLoadingStatus?(isFetching)
        }
    }
    
    private var isLocationAccessible: Bool? {
        didSet {
            updateLocationAccessStatus?(isLocationAccessible)
        }
    }
    
    private var dataSource: [String: [ForecastData]] = [:] {
        didSet {
            var datesArray = Array(dataSource.keys).compactMap{
                                    return $0.getDate() }
            
            datesArray = datesArray.sorted {
                            $0.compare($1) == .orderedAscending }
            
            dates = datesArray.compactMap({
                        return $0.getDateString()
                    })
            updateCellModels()
            reloadClosure?()
        }
    }
    
    
    var dates : [String] = []
    var cellModels: [String: [ForecastCellViewModel]] = [:]
    var reloadClosure: (() -> ())?
    var updateCurrentLocation: ( (String?)->() )?
    var updateLoadingStatus: ( (Bool)->() )?
    var updateLocationAccessStatus: ((Bool?)->())?
    
    
    override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
    }
    
    func fetchForecastForTest() {
        updateForecast()
    }
    
    private func updateForecast() {
        isFetching = true
        
        getWeatherForecast { [weak self] (result) in
            self?.isFetching = false
            
            switch result {
            case .success(let forecast):
                self?.updateDataSourceWithForecast(forecast)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    

    private func updateDataSourceWithForecast(_ forecast: Forecast) {
        
        city = forecast.city.name +  ", " + forecast.city.country
        var tempDataSource = [String: [ForecastData]]()
        
        for item in forecast.list {
            if let date = item.dt_txt.components(separatedBy: " ").first {
                var hourlyData: [ForecastData] = tempDataSource[date] ?? []
                hourlyData.append(item)
                tempDataSource[date] = hourlyData
            }
        }
        dataSource = tempDataSource
    }
    
    private func updateCellModels() {
        for date in dates {
            var models : [ForecastCellViewModel] = []
            if let forecastItems = dataSource[date] {
                for item in forecastItems {
                    models.append(createCellModelswith(forecast: item))
                }
                cellModels[date] = models
            }
        }
    }
    
    private func createCellModelswith(forecast: ForecastData)
                                    -> ForecastCellViewModel {
            
        let time = forecast.dt_txt.get12hrTimeFormattedString() ?? ""
                                        
        let temp = convertTemp(temp: forecast.main.temp_max,
                               to: UnitTemperature.celsius)
        let minTemp = convertTemp(temp: forecast.main.temp_min,
                                  to: UnitTemperature.celsius)
        
        let cellViewmodel = ForecastCellViewModel(timeString:time,
                                                  maxTemp: temp,
                                                  minTemp: minTemp,
                                                  weatherDescription: forecast.weather.first?.type ?? "",
                                                  windSpeed: "\(forecast.wind.speed)")
        return cellViewmodel
    }
    
    func getCellViewModelFor(row: Int, date:String) -> ForecastCellViewModel? {
        return cellModels[date]?[row] ?? nil
    }
    
    
    //MARK: Network calls
    func getWeatherForecast(completion: @escaping (Result<Forecast, CWError>) -> Void) {

        guard let cordinates = currentCordinates else { return }
        let params = [Constants.appID: CWConstants.appID,
                      Constants.lat: cordinates.latitude,
                      Constants.lon : cordinates.longitude] as [String : Any]
        
        NetworkManager.request(route: WeatherAPIRouter.getForecast(params: params),                     completion: completion)
      }
    
}

extension ForecastViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentCordinates = locValue
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .denied || status == .restricted {
            isLocationAccessible = false
        }
    }
}
