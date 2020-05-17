//
//  HomeViewModel.swift
//  CityWeather
//
//  Created by Christeena John on 12/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation

class HomeViewModel {
    private struct Constants {
        static let minimum = 3
        static let maximum = 7
    }
    
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
    /* This function checking whether the city input is valid
       Min 3 and max 7 city names separated by coma is valid input
       Validate empty words */
    var updateUIForValidInput: ((Bool) -> ())?
    
    // MARK: Private methods
    // This method is used to validate the input for search requirement
    // - input will be coma separated city names
    //
    private func validateInput() {
        if let citiesArray = input?.components(separatedBy: ",") {
            cities = citiesArray.map { $0.components(separatedBy: .whitespaces).joined()}
                .filter { $0.count > 0 }
            
            if cities.count >= Constants.minimum &&
                cities.count <= Constants.maximum {
                canFindWeather = true
                return
            }
        }
        canFindWeather = false
    }
}

