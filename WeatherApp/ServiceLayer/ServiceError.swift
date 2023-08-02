//
//  ServiceError.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 02.08.2023.
//

import Foundation

enum ServiceError: String, Error {
    case invalidUrl = "Bad URL"
    case failedLocation = "User location get failed"
}
