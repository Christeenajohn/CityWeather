//
//  CWUtilities.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import UIKit

func showAlert( _ message: String, presenter: UIViewController ) {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
    alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    presenter.present(alert, animated: true, completion: nil)
}

func convertTemp(temp: Double, to outputTempType: UnitTemperature) -> String {
      let mf = MeasurementFormatter()
      mf.numberFormatter.maximumFractionDigits = 0
      mf.unitOptions = .providedUnit
      let input = Measurement(value: temp, unit: UnitTemperature.kelvin)
      let output = input.converted(to: outputTempType)
      return mf.string(from: output)
}

var cityWeather: [String: Weather] = [:]
var dateFormatter = DateFormatter()

extension String {
    
    func getDate() -> Date? {
        //2020-05-13 12:00:00
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
    
    func getDateFromDisplayString() -> Date? {
        dateFormatter.dateFormat = "E, d MMM yyyy"
        return dateFormatter.date(from: self)
    }
    
    func get12hrTimeFormattedString() -> String? {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date =  dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}

extension Date {
    
    func getDateString() -> String? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func getDateDisplayString() -> String? {
        dateFormatter.dateFormat = "E, d MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
