//
//  DateFormatterTests.swift
//  CityWeatherTests
//
//  Created by Christeena John on 17/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import XCTest

class DateTests: XCTestCase {
    
    func testDateString() {
        let dateString = "2020-05-17"
        if let date = dateString.getDate() {
            let result = date.getDateString() ?? "Failed"
            XCTAssertEqual(result, dateString)
        }
    }
    
    func testDateDisplayString() {
        let dateString = "2020-05-17"
        if let date = dateString.getDate() {
            let result = date.getDateDisplayString() ?? "Failed"
            let expectedResult = "Sun, 17 May 2020"
            XCTAssertEqual(result, expectedResult)
        }
    }
    
    func test12hrTimeString() {
        let dateString = "2020-05-17 09:00:00"
        let result = dateString.get12hrTimeFormattedString() ?? "Failed"
        let expectedResult = "01:00 PM"
        XCTAssertEqual(result, expectedResult)
        
    }

}
