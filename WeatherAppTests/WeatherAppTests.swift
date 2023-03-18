//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Yan Rybkin on 18.03.2023.
//

import XCTest
@testable import WeatherApp

class MockView: MainViewProtocol {
	func succes() {
	}
	func failure(error: Error) {
	}
}
class MockMainService: MainServiceProtocol {
	required init(networkService: WeatherApp.NetworkServiceProtocol, locationService: WeatherApp.LocationServiceProtocol) {}
	
	var weather: Weather!
	
	//MARK: For testFailureGetWeather
	init() {}
	
	//MARK: For testSuccesGetWeather
	convenience init(forecast: Weather?) {
		self.init()
		self.weather = forecast
	}
	
	func getWeather(adress: String, completion: @escaping (Result<WeatherApp.Weather?, Error>) -> Void) {
		if let weather = weather {
			completion(.success(weather))
		} else {
			let error = NSError(domain: "", code: 0)
			completion(.failure(error))
		}
	}
}

final class WeatherAppTests: XCTestCase {
	
	var view: MockView!
	var presenter: MainPresenter!
	var locationService: LocationServiceProtocol!
	var networkService: NetworkServiceProtocol!
	var mainService: MainServiceProtocol!
	var weather: Weather!
	
	override func setUpWithError() throws {}
	
	override func tearDownWithError() throws {
		view            = nil
		locationService = nil
		networkService  = nil
		mainService     = nil
		presenter       = nil
	}
	
	func testSuccesGetWeather() throws {
		// Given
		let weather = Weather(
			geoObject: GeoObject(province: Country(name: "Foo")),
			fact: Fact(temp: 10, feelsLike: 10, icon: nil,condition: nil),
			forecasts: nil)
		let adress = "Bar"
		var catchWheather: Weather?
		view = MockView()
		mainService = MockMainService(forecast: weather)
		presenter = MainPresenter(view: view, mainService: mainService)
		// When
		mainService.getWeather(adress: adress) { result in
			switch result {
			case .success(let weather):
				catchWheather = weather
			case .failure(let error):
				print(error)
			}
		}
		// Then
		XCTAssertNotNil(catchWheather)
		XCTAssertEqual(catchWheather?.fact.temp, weather.fact.temp)
	}
	
	func testFailureGetWeather() throws {
		// Given
		var catchError: Error?
		let adress = "Foo"
		view = MockView()
		mainService = MockMainService()
		presenter = MainPresenter(view: view, mainService: mainService)
		// When
		mainService.getWeather(adress: adress) { result in
			switch result {
			case .success( _):
				break
			case .failure(let error):
				catchError = error
			}
		}
		// Then
		XCTAssertNotNil(catchError)
	}
	
	func testPresenterSetLocation() throws {
		// Given
		let adress = "Baz"
		view = MockView()
		mainService = MockMainService()
		presenter = MainPresenter(view: view, mainService: mainService)
		// When
		presenter.setLocation(adress: adress)
		// Then
		XCTAssertEqual(presenter.location, adress)
	}
	
	
	func testPresenterGetLocation() throws {
		// Given
		let adress = "Baz"
		let savedLocation: String?
		view = MockView()
		mainService = MockMainService()
		presenter = MainPresenter(view: view, mainService: mainService)
		// When
		presenter.setLocation(adress: adress)
		// Then
		savedLocation = UserDefaults.standard.string(forKey: "location")
		XCTAssertEqual(savedLocation, adress)
	}
	
	func testPresenterGetDateArray() throws {
		// Given
		// When
		// Then
	}
	func testPresenterGetTimeArray() throws {
		// Given
		// When
		// Then
	}
}

