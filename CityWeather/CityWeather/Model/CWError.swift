//
//  CWError.swift
//  CityWeather
//
//  Created by Christeena John on 16/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation

enum CWError: Error {
    case defaultError
    case noInternet
    case customError(errors: [String: Any]?)
}

extension CWError {
    private struct ErrorKeys {
        static let message = "message"
    }
    
    var errorDescription: String {
        switch self {
        case .defaultError:
            return CWErrorMessages.defaultError
        case .noInternet:
            return CWErrorMessages.noInternerError
        case .customError(let errors):
            guard let message = errors?[ErrorKeys.message] as? String else {
                return CWErrorMessages.defaultError
            }
            return message
        }
    }
}
