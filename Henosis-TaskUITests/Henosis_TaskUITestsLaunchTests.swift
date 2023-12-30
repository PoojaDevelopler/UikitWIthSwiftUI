//
//  Henosis_TaskUITestsLaunchTests.swift
//  Henosis-TaskUITests
//
//  Created by pnkbksh on 29/12/23.
//

import XCTest

final class Henosis_TaskUITestsLaunchTests: XCTestCase {
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    
    func testIngredientsButtonsExist() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Ingredients"].exists)
    }
    
    func testIngredientsButtonAction() {
        let app = XCUIApplication()
        app.launch()
        
        let ingredientButton = app.buttons["Ingredients"].firstMatch
        XCTAssertTrue(ingredientButton.waitForExistence(timeout: 5))
        ingredientButton.tap()
    }
    
    
    func testMoreButtonButtonsExist() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["More"].exists)
    }
    
    func testMoreButtonAction() {
        let app = XCUIApplication()
        app.launch()
        
        let moreButton = app.buttons["More"].firstMatch
        XCTAssertTrue(moreButton.waitForExistence(timeout: 5))
        moreButton.tap()
    }
    
    // for fail case 
    func testButtonExistsAndTappable() throws {
        let app = XCUIApplication()
        app.launch()
        let myButton = app.buttons["DummyTestForFail"]  
        XCTAssertTrue(myButton.exists, "Button does not exist")
        
        myButton.tap()
        
    }
    
    
    // test filter option
    func testFilterFunctionality() throws {
        let app = XCUIApplication()
        app.launch()
        
        
        let allFilterBtn = app.buttons["All"]
        XCTAssertTrue(allFilterBtn.exists, "Button does not exist")
        allFilterBtn.tap()

        let alcholFilterBtn = app.buttons["Alchol"]
        XCTAssertTrue(alcholFilterBtn.exists, "Button does not exist")
        alcholFilterBtn.tap()

        
        let nonAlcholFilterBtn = app.buttons["Non-Alchol"]
        XCTAssertTrue(nonAlcholFilterBtn.exists, "Button does not exist")
        nonAlcholFilterBtn.tap()
        
    }
  
}


