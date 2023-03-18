//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Yan Rybkin on 18.03.2023.
//

import XCTest
@testable import WeatherApp

final class WeatherAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
	}
	
    override func tearDownWithError() throws {}
	
	func testSwipeWeeklyWeatherSetCell() throws {
		let app = XCUIApplication()
		app.launch()
		
		let weeklyWeatherSetCell = app.cells["WeeklyWeatherSetCell"]
		XCTAssertTrue(weeklyWeatherSetCell.waitForExistence(timeout: 5), "Cell not found")
		
		weeklyWeatherSetCell.swipeLeft()
		weeklyWeatherSetCell.swipeRight()
	}
	
	func testSetNewLocationButton() throws {
		let app = XCUIApplication()
		app.launch()
		
		let addBarButtonItem = app.navigationBars["WeatherApp.MainView"].buttons["addBarButtonItem"]
		let newLocItem = app.collectionViews.buttons["newLocItem"]
		let locationTextField = app.textFields["locationTextField"]
		let okAction = app.scrollViews.otherElements.buttons["okAction"]
		
		addBarButtonItem.tap()
		newLocItem.tap()
		locationTextField.tap()
		locationTextField.typeText("Saint-Petersburg")
		okAction.tap()
	}
}
