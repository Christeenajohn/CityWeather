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
    
    // MARK: Private Methods
    /* 3 states for cells
       When isFetching = true, show loading experience
       When isValid = false, no city found error from response => show error
       When we have valid data, show the data */
    private func updateVisibilty(_ model: CityWeatherCellModel) {
        noDataLabel.isHidden = model.isValid ?? true
        dataHolder.isHidden = !(model.isValid ?? false)
        model.isFetching ? loader.startAnimating() : loader.stopAnimating()
    }
    
    // MARK: Public Methods
    //
    func updateCellWithModel(_ model: CityWeatherCellModel)  {
        updateVisibilty(model)
        
        if model.isValid == true {
            nameField.text = model.name
            descriptionField.text = model.weatherDescription.capitalized
            windField.text = model.windSpeed
            maxTempField.text = model.maxTemp
            minTempField.text = model.minTem
        }
    }
}
