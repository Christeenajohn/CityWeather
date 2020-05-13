//
//  HomeViewModel.swift
//  CityWeather
//
//  Created by Christeena John on 12/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var input: String? {
        didSet {
            validateInput()
        }
    }
    var cities:[String] = []
    
    var canFindWeather: Bool = false {
        didSet {
            updateUIForValidInput?(canFindWeather)
        }
    }
    
    // MARK: Binding functions
    var updateUIForValidInput: ((Bool) -> ())?
    
    
    
    // MARK: Private methods
    private func validateInput() {
        /// This method is used to validate the input for search requirement
        /// - input will be coma separated city names
        
        if let citiesArray = input?.components(separatedBy: ",") {
            cities = citiesArray.map {
                $0.components(separatedBy: .whitespaces).joined().trimmingCharacters(in: .whitespacesAndNewlines)
            }.filter { $0.count > 0 }
            
            if cities.count > 2 && cities.count < 8 {
                canFindWeather = true
                return
            }
            
        }
         canFindWeather = false
    }
    
    
    
}
