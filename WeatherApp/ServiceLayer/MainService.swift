//
//  MainService.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 17.03.2023.
//

import Foundation

protocol MainServiceProtocol: AnyObject {
	var networkService: NetworkServiceProtocol { get }
	var locationService: LocationServiceProtocol { get }
	
	func getWeather(adress: String, completion: @escaping (Result<Weather?, Error>) -> Void)
}

class MainService: MainServiceProtocol {
	let networkService: NetworkServiceProtocol
	let locationService: LocationServiceProtocol
	
	init(networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
		self.networkService = networkService
		self.locationService = locationService
	}
	
	func getWeather(adress: String, completion: @escaping (Result<Weather?, Error>) -> Void) {
		locationService.getUserLocation(from: adress) { userLocation in
			guard let userLocation = userLocation else {
				completion(.failure(NSError(domain: "Unable to get user location", code: 0, userInfo: nil)))
				return
			}
			self.networkService.getForecast(latitude: userLocation[0], longitude: userLocation[1]) { result in
				completion(result)
			}
		}
	}
}
