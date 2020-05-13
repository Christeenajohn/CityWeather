//
//  NetworkManager.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation
import Alamofire

enum CWError: Error {
    case defaultError
    case noInternet
    case customError(errors: [String: Any]?)
}

struct CWConstants {
    static let appID = "e72ca729af228beabd5d20e3b7749713"
    static let rootURL = "https://api.openweathermap.org/data/2.5/"
}


class NetworkManager {
    
    public static func request<T: Decodable> (route: APIRouter,
                                             completion: @escaping (Result<T, CWError>) -> Void) {
        
        guard Reachability.shared.isConnectedToInternet() == true else {
            completion(.failure(.noInternet))
            return
        }
        
        AF.request(route)
            .responseJSON { (response) in
                
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        completion(.failure(.defaultError))
                        return
                    }
   
                    do {
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(T.self, from: data)
                        completion(.success(model))
                    } catch {
                        if let value = response.value as? [String: Any]{
                            completion(.failure(.customError(errors: value)))
                        }
                        completion(.failure(.defaultError))
                    }
                    
                case .failure:
                    completion(.failure(.defaultError))
                }
        }
    }
    
}
