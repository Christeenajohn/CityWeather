//
//  HomeTests.swift
//  CityWeatherTests
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import XCTest

class HomeTests: XCTestCase {
    let sut = HomeViewModel()

    override func setUp() {
    }

    override func tearDown() {
    }

    func testInputOf3Cities() {
        let input = "Dubai, Abu Dhabi, Sharjah"
        sut.input = input
        XCTAssertEqual(sut.canFindWeather, true)
    }
    
    func testInputOf7Cities() {
        let input = "Dubai, Abu Dhabi, Sharjah, Ajman, Paris, Tblisi, Kazbegi"
        sut.input = input
        XCTAssertEqual(sut.canFindWeather, true)
    }
    
    func testInputOfMoreThan7Cities() {
        let input = "Dubai, Abu Dhabi, Sharjah, Ajman, Paris, Tblisi, Kazbegi, London"
        sut.input = input
        XCTAssertEqual(sut.canFindWeather, false)
    }
    
    func testInputOfLessThan3Cities() {
        let input = "Dubai"
        sut.input = input
        XCTAssertEqual(sut.canFindWeather, false)
    }


}
