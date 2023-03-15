//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 15.03.2023.
//

import Foundation

protocol NetworkServiceProtocol {
	func getForecast(completion: @escaping ( Result<[Weather]?, Error>) -> Void )
}

class NetworkService: NetworkServiceProtocol {
	func getForecast(completion: @escaping (Result<[Weather]?, Error>) -> Void) {
		
		let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393&extra=true"
		guard let url = URL(string: urlString) else {
			completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
			return
		}
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "GET"
		urlRequest.addValue("c64016b4-04d5-41ce-9816-2b54a6229173", forHTTPHeaderField: "X-Yandex-API-Key")
		
		let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
			guard let data = data else {
				completion(.failure(error ?? NSError(domain: "Invalid data", code: 0, userInfo: nil)))
				return
			}
			do {
				let objects = try JSONDecoder().decode([Weather].self, from: data)
				completion(.success(objects))
			} catch {
				completion(.failure(error))
			}
		}
		task.resume()
	}
}
