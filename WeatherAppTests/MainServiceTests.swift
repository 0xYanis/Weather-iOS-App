//
//  MainServiceTests.swift
//  WeatherAppTests
//
//  Created by Yan Rybkin on 18.03.2023.
//

import XCTest
@testable import WeatherApp

class MockNetworkService: NetworkServiceProtocol {
	var getForecastCalled = false
	var getForecastLatitude: Double?
	var getForecastLongitude: Double?
	
	func getForecast(latitude: Double, longitude: Double, completion: @escaping (Result<Weather?, Error>) -> Void) {
		getForecastCalled = true
		getForecastLatitude = latitude
		getForecastLongitude = longitude
		
		// Return a default Weather result
		completion(.success(Weather(geoObject: GeoObject(province: Country(name: "Foo")),
									fact: Fact(temp: 10, feelsLike: 10, icon: nil, condition: nil),
									forecasts: nil)))
	}
}

class MockLocationService: LocationServiceProtocol {
	var stubbedUserLocation: [Double]?
	
	func getUserLocation(from address: String, completion: @escaping ([Double]?) -> Void) {
		completion(stubbedUserLocation)
	}
}

final class MainServiceTests: XCTestCase {
	
	var mainService: MainService!
	var mockNetworkService: MockNetworkService!
	var mockLocationService: MockLocationService!
	
	override func setUp() {
		super.setUp()
		
		mockNetworkService = MockNetworkService()
		mockLocationService = MockLocationService()
		
		mainService = MainService(networkService: mockNetworkService, locationService: mockLocationService)
	}
	
	override func tearDown() {
		mainService = nil
		mockNetworkService = nil
		mockLocationService = nil
		
		super.tearDown()
	}
	
	func testGetWeather_whenLocationServiceReturnsNil_shouldCompleteWithError() {
		// Given
		mockLocationService.stubbedUserLocation = nil
		let expect = expectation(description: "Completion should be called with error")
		let message = "The operation couldn’t be completed. (Unable to get user location error 0.)"
		// When
		mainService.getWeather(adress: "Foo") { result in
			switch result {
			case .success(_):
				XCTFail("Expected to get an error, but got a success")
			case .failure(let error):
				XCTAssertEqual(error.localizedDescription, message)
			}
			expect.fulfill()
		}

		// Then
		waitForExpectations(timeout: 1, handler: nil)
	}
	
	func testGetWeather_whenLocationServiceReturnsLocation_shouldCallNetworkService() {
		// Given
		mockLocationService.stubbedUserLocation = [12.3, 45.6]
		
		let expect = expectation(description: "Completion should be called")
		
		// When
		mainService.getWeather(adress: "Baz") { _ in
			expect.fulfill()
		}
		
		// Then
		waitForExpectations(timeout: 1) { error in
			XCTAssertTrue(self.mockNetworkService.getForecastCalled)
			XCTAssertEqual(self.mockNetworkService.getForecastLatitude, 12.3)
			XCTAssertEqual(self.mockNetworkService.getForecastLongitude, 45.6)
		}
	}
}
