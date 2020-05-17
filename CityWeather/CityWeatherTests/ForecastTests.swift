//
//  ForecastTests.swift
//  CityWeatherTests
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import XCTest
import CoreLocation

class ForecastTests: XCTestCase {

    let sut = ForecastViewModel()
    
    override func setUp() {
        sut.currentCordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(25.2048), longitude: CLLocationDegrees(55.2708))
    }

    override func tearDown() {
    }
    
    func testCityName()  {
        var isAE = false
        
        sut.fetchForecastForTest()
        let expectation = self.expectation(description: "TestCity")
        
        sut.updateCurrentLocation = { (city) in
            if let city = city,
                city.contains(", AE") || city.contains(", US") {
                isAE = true
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(isAE)
    }
    
    
    func testForecastData()  {
        var isFulfilled = false
        sut.fetchForecastForTest()
        let expectation = self.expectation(description: "testForecastData")
        
        sut.reloadClosure = {
            if !isFulfilled  {
                isFulfilled = true
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5)
        XCTAssert(sut.dates.count >= 5)
    }

}
