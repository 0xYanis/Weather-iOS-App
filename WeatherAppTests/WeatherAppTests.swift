//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Yan Rybkin on 18.03.2023.
//

import XCTest
@testable import WeatherApp

class MockView: MainViewProtocol {
	var textTest: String?
	func succes() {
		textTest = "OK"
	}
	func failure(error: Error) {
		textTest = "ERROR"
	}
}

class MockNetworkService: NetworkServiceProtocol {
	func getForecast(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherApp.Weather?, Error>) -> Void) {}
}

class MockLocationService: LocationServiceProtocol {
	func getUserLocation(from address: String, completion: @escaping ([Double]?) -> Void) {}
}

class MockMainService: MainServiceProtocol {
	var networkService: NetworkServiceProtocol!
	var locationService: LocationServiceProtocol!
	func getWeather(adress: String, completion: @escaping (Result<WeatherApp.Weather?, Error>) -> Void) {
		<#code#>
	}
	
	
}

final class WeatherAppTests: XCTestCase {
	
	var view: MockView!
	var locationService: LocationServiceProtocol!
	var networkService: NetworkServiceProtocol!
	var mainService: MainServiceProtocol!
	var presenter: MainPresenterProtocol!
	
    override func setUpWithError() throws {
		view = MockView()
		locationService = LocationService()
		networkService = NetworkService()
		mainService = MainService(networkService: networkService, locationService: locationService)
		presenter = MainPresenter(view: view, mainService: mainService)
	}
	
    override func tearDownWithError() throws {
		view            = nil
		locationService = nil
		networkService  = nil
		mainService     = nil
		presenter       = nil
	}
	
	func testModuleIsNotNil() throws {
		XCTAssertNotNil(view, "view is not nil")
		XCTAssertNotNil(locationService, "locationService is not nil")
		XCTAssertNotNil(networkService, "networkService is not nil")
		XCTAssertNotNil(mainService, "mainService is not nil")
		XCTAssertNotNil(presenter, "presenter is not nil")
	}
	
	func testView() throws {
		// Given
		presenter.
		// When
		
		// Then
		
	}
}
