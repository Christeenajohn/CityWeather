//
//  CityWeatherTests.swift
//  CityWeatherTests
//
//  Created by Christeena John on 12/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import XCTest

class CityWeatherTests: XCTestCase {
    let sut = CityWeatherViewModel()

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testEqualNumberOfViewModelsCreated() {
        sut.cities = ["Dubai"]
        XCTAssertEqual(sut.numberOfCells, 1)
    }

    func testSuccessfulWeatherFetching() {
        sut.cities = ["Dubai"]
        let expectation = self.expectation(description: "Weather fetching")
        
        sut.reloadTableClosure = {
            if self.sut.getCellViewForCity("Dubai").isFetching == false {
                expectation.fulfill()
            }
        }
        sut.configureCellViewModel(city: "Dubai")
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.getCellViewForCity("Dubai").isValid, true)
    }
    
    func testWeatherFetchingFailure() {
        sut.cities = ["aj"]
        var isFulFilled = false
        
        let expectation = self.expectation(description: "Weather fetching failure")
        
        sut.reloadTableClosure = {
            if self.sut.getCellViewForCity("aj").isFetching == false
                && isFulFilled == false  {
                
                isFulFilled = true
                expectation.fulfill()
            }
        }
        sut.configureCellViewModel(city: "aj")
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.getCellViewForCity("aj").isValid, false)
    }
}
