//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 18.03.2023.
//

import Foundation

enum NetworkError: String, Error {
	case badRequest
	case unauthorized
	case notFound
	case serverError
	case unknown
}
