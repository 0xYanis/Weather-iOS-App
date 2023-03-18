//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Yan Rybkin on 18.03.2023.
//

import XCTest

final class WeatherAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
	}

    override func tearDownWithError() throws {}

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
		
        
    }
}
