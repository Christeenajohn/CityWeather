//
//  CityWeatherUITests.swift
//  CityWeatherUITests
//
//  Created by Christeena John on 12/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import XCTest

class CityWeatherUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
    }

    func testInvalidInput() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.textViews.element.tap()
    
        app.buttons["Serach"].tap()

        XCTAssert(app.alerts["Please provide valid input. Valid input can contain 3 to 7 city names separated by comma."].exists)
    }
    

    func testValidInputNavigation() {
        let app = XCUIApplication()
        app.launch()
        let input = app.textViews.element
        input.tap()
        input.typeText("Dubai, Paris, Lo")
        
        app.buttons["Serach"].tap()
        
        XCTAssert(app.collectionViews.element.exists)
    }
    
    
    func testResponseData() {

        let app = XCUIApplication()
        app.launch()
        let input = app.textViews.element
        input.tap()
        input.typeText("Dubai, Paris, Lo")
        
        app.buttons["Serach"].tap()
        
        let label = app.staticTexts["Dubai"]
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInvalidCity() {
        
        let app = XCUIApplication()
        app.launch()
        let input = app.textViews.element
        input.tap()
        input.typeText("Dubai, Lo, Paris")
        
        app.buttons["Serach"].tap()
        
        app.collectionViews.element.swipeLeft()
                
        let label = app.staticTexts["City not found"]
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    



}
