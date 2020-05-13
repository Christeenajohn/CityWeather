//
//  WeatherDetailsCell.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import UIKit

class WeatherDetailsCell: UICollectionViewCell {
    
    @IBOutlet weak var descriptionField: UILabel!
    @IBOutlet weak var minTempField: UILabel!
    @IBOutlet weak var maxTempField: UILabel!
    @IBOutlet weak var windField: UILabel!
    @IBOutlet weak var dataHolder: UIView!
    @IBOutlet weak var nameField: UILabel!
    
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private func updateVisibilty(_ model: CityWeatherCellModel) {
        noDataLabel.isHidden = model.isValid ?? true
        dataHolder.isHidden = !(model.isValid ?? false)
        model.isFetching ? loader.startAnimating() : loader.stopAnimating()
    }
    
    
    func updateCellWithModel(_ model: CityWeatherCellModel)  {
        updateVisibilty(model)
        
        if model.isValid == true {
            nameField.text = model.name
            descriptionField.text = model.weatherDescription.capitalized
            
            if let maxTemperature = Double(model.maxTemp),
                let minTemperature = Double(model.minTem) {
                minTempField.text = convertTemp(temp:minTemperature,
                                                to: UnitTemperature.celsius)
                maxTempField.text = convertTemp(temp: maxTemperature,
                                                to: UnitTemperature.celsius)
            }

            windField.text = model.windSpeed
        }

    }
}
