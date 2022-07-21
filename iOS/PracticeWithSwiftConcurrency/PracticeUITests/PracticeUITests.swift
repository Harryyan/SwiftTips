//
//  PracticeUITests.swift
//  PracticeUITests
//
//  Created by Harry Yan on 18/07/22.
//

import XCTest

final class PracticeUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    func testExample() throws {
//        let tablesQuery = app.tables
        app/*@START_MENU_TOKEN@*/.staticTexts["Eau De Perfume Spray"]/*[[".cells.staticTexts[\"Eau De Perfume Spray\"]",".staticTexts[\"Eau De Perfume Spray\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
