//
//  Model.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 14.03.2023.
//

import Foundation

struct Model: Decodable {
	let lat, lon: Double
	let timezone: String
	let timezoneOffset: Int
	let current: Current?
	
	enum CodingKeys: String, CodingKey {
		case lat, lon, timezone
		case timezoneOffset = "timezone_offset"
		case current
	}
}

struct Current: Decodable {
	let dt, sunrise, sunset: Int
	let temp, feelsLike: Double
	let pressure, humidity: Int
	let dewPoint, uvi: Double
	let clouds, visibility: Int
	let windSpeed: Double
	let windDeg: Int
	let windGust: Double
	let weather: [Weather]

	enum CodingKeys: String, CodingKey {
		case dt, sunrise, sunset, temp
		case feelsLike = "feels_like"
		case pressure, humidity
		case dewPoint = "dew_point"
		case uvi, clouds, visibility
		case windSpeed = "wind_speed"
		case windDeg = "wind_deg"
		case windGust = "wind_gust"
		case weather
	}
}

struct Weather: Decodable {
	let id: Int
	let main, description, icon: String
}
