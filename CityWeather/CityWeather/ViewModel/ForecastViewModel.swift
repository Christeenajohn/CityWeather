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
    
    // MARK: data source
    var dates : [String] = []
    var cellModels: [String: [ForecastCellViewModel]] = [:]
    
    // MARK: Binding closure methods
    var reloadClosure: (() -> ())?
    var updateCurrentLocation: ( (String?)->() )?
    var updateLoadingStatus: ( (Bool)->() )?
    var updateLocationAccessStatus: ((Bool?)->())?
    var currentCordinates : CLLocationCoordinate2D? {
        didSet {
            updateForecast()
        }
    }
    
    // MARK: Private properties
    private let locationManager = CLLocationManager()
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
    
    override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.distanceFilter = 1000.0;
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
    }
    
    func fetchForecastForTest() {
        updateForecast()
    }
    
    private func updateForecast() {
        guard isFetching == false else {
            return
        }
        
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
            if let date = item.dtTxt.getDateTime()?.getDateString() {
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
            
            let time = forecast.dtTxt.get12hrTimeFormattedString() ?? ""
            
            let temp = convertTemp(temp: forecast.main.tempMax,
                                   to: UnitTemperature.celsius)
            let minTemp = convertTemp(temp: forecast.main.tempMin,
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
        let params = [Constants.appID: APIConstants.appID,
                      Constants.lat: cordinates.latitude,
                      Constants.lon : cordinates.longitude] as [String : Any]
        
        NetworkManager.request(route: WeatherAPIRouter.getForecast(params: params),
                               completion: completion)
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

