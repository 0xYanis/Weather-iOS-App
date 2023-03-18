//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 15.03.2023.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol: AnyObject {
	func getForecast(latitude: Double, longitude: Double, completion: @escaping (Result<Weather?, Error>) -> Void )
}

class NetworkService: NetworkServiceProtocol {
	
	private let language = "en_US"
	private let apiKey = "c64016b4-04d5-41ce-9816-2b54a6229173"
	
	func getForecast(latitude: Double, longitude: Double, completion: @escaping (Result<Weather?, Error>) -> Void) {
		let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)&lang=\(language)"
		guard let url = URL(string: urlString) else {
			completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
			return
		}
		let headers: HTTPHeaders = ["X-Yandex-API-Key": apiKey]
		
		AF.request(url, headers: headers).validate().responseDecodable(of: Weather.self) { response in
			switch response.result {
			case .success(let objects):
				completion(.success(objects))
			case .failure(let error):
				let statusCode = response.response?.statusCode
				if let statusCode = statusCode {
					switch statusCode {
					case 400:
						completion(.failure(NetworkError.badRequest))
					case 401:
						completion(.failure(NetworkError.unauthorized))
					case 404:
						completion(.failure(NetworkError.notFound))
					case 500...599:
						completion(.failure(NetworkError.serverError))
					default:
						completion(.failure(error))
					}
				} else {
					completion(.failure(error))
				}
			}
		}
	}
}
