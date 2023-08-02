//
//  MainService.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 17.03.2023.
//

import Foundation

protocol MainServiceProtocol: AnyObject {
    typealias CompletionBlock = (Result<Weather?, Error>) -> Void
	func getWeather(adress: String, completion: @escaping CompletionBlock)
}

class MainService: MainServiceProtocol {
    
    typealias CompletionBlock = (Result<Weather?, Error>) -> Void
    
	let networkService: NetworkServiceProtocol
	let locationService: LocationServiceProtocol
	
	init(
        networkService: NetworkServiceProtocol = NetworkService(),
        locationService: LocationServiceProtocol = LocationService()
    ) {
		self.networkService = networkService
		self.locationService = locationService
	}
	
	func getWeather(adress: String, completion: @escaping CompletionBlock) {
		locationService.getUserLocation(from: adress) { [weak self] userLocation in
			guard let self = self else { return }
			
			guard let userLocation = userLocation else {
                completion(.failure(ServiceError.failedLocation))
				return
			}
			
			self.networkService.getForecast(
                latitude: userLocation[0],
                longitude: userLocation[1]
            ) { result in
				completion(result)
			}
		}
	}
    
}
