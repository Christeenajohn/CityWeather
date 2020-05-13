//
//  ForecastCell.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    func updateDataWith(_ cellVM: ForecastCellViewModel)  {
        timeLabel.text = cellVM.timeString
        minTempLabel.text = cellVM.minTemp
        descriptionLabel.text = cellVM.weatherDescription.capitalized
        tempLabel.text = cellVM.maxTemp
        windLabel.text = cellVM.windSpeed
    }
}

class ForecaseDateCell: UITableViewCell {
     @IBOutlet weak var dateLabel: UILabel!
}
