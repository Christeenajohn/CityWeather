//
//  Reachability.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation
import Alamofire


final class Reachability: NSObject {
   
    static let shared = Reachability()
    let reachabilityManager = NetworkReachabilityManager()
    
    /// This prevents singleton multiple initialization.
    private override init() { }
    
    func isConnectedToInternet() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }
    
    func startNetworkMonitoring() {
        self.reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                print("No internet connection")
            case .reachable:
                print("Internet connected")
            case .unknown:
                print("Unknown internet connection")
            }
        }
    }
    
    func stopNetworkMonitoring() {
        self.reachabilityManager?.stopListening()
    }
}
