//
//  CWUtilities.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import UIKit

func showAlert( _ message: String, presenter: UIViewController ) {
    let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
    alert.addAction( UIAlertAction(title: Alert.ok, style: .cancel, handler: nil))
    presenter.present(alert, animated: true, completion: nil)
}

func convertTemp(temp: Double, to outputTempType: UnitTemperature) -> String {
      let mf = MeasurementFormatter()
      mf.numberFormatter.maximumFractionDigits = 1
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
        dateFormatter.dateFormat = Date.defaultFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: self)
    }
    
    func getDateTime() -> Date? {
        //2020-05-13 12:00:00
        dateFormatter.dateFormat = Date.dateTimeFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: self)
    }
    
    func getDateFromDisplayString() -> Date? {
        dateFormatter.dateFormat = Date.weekDayFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: self)
    }
    
    func get12hrTimeFormattedString() -> String? {
        dateFormatter.dateFormat = Date.dateTimeFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date =  dateFormatter.date(from: self) {
            dateFormatter.dateFormat = Date.timeFormat
            dateFormatter.timeZone = TimeZone.current
            return dateFormatter.string(from: date)
        }
        return nil
    }
}

extension Date {
    static let defaultFormat    = "yyyy-MM-dd"
    static let weekDayFormat    = "E, d MMM yyyy"
    static let dateTimeFormat   = "yyyy-MM-dd HH:mm:ss"
    static let timeFormat       = "hh:mm a"
    
    func getDateString() -> String? {
        dateFormatter.dateFormat = Date.defaultFormat
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    func getDateDisplayString() -> String? {
        dateFormatter.dateFormat = Date.weekDayFormat
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
}
