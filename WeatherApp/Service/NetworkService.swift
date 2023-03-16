//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 15.03.2023.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
	func getForecast(completion: @escaping ( Result<Weather?, Error>) -> Void )
}

class NetworkService: NetworkServiceProtocol {
	func getForecast(completion: @escaping (Result<Weather?, Error>) -> Void) {
		let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393"
		guard let url = URL(string: urlString) else {
			completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
			return
		}
		let headers: HTTPHeaders = ["X-Yandex-API-Key": "c64016b4-04d5-41ce-9816-2b54a6229173"]

		AF.request(url, headers: headers).responseDecodable(of: Weather.self) { response in
			switch response.result {
			case .success(let objects):
				completion(.success(objects))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
