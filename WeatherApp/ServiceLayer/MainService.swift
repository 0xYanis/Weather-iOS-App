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
	
	func getWeather(completion: @escaping (Result<Weather?, Error>) -> Void)
}

class MainService: MainServiceProtocol {
	let networkService: NetworkServiceProtocol
	let locationService: LocationServiceProtocol
	
	init(networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
		self.networkService = networkService
		self.locationService = locationService
	}
	
	func getWeather(completion: @escaping (Result<Weather?, Error>) -> Void) {
		guard let userLocation = locationService.getUserLocation() else {
			completion(.failure(NSError(domain: "Unable to get user location", code: 0, userInfo: nil)))
			return
		}
		
		networkService.getForecast(latitude: userLocation[0], longitude: userLocation[1]) { result in
			completion(result)
		}
	}
}
