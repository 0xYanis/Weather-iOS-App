//
//  Weather.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 15.03.2023.
//

import Foundation

struct Weather: Decodable {
	let geoObject: GeoObject?
	let fact: Fact?
	let forecasts: [Forecast]?
	
	enum CodingKeys: String, CodingKey {
		case geoObject = "geo_object"
		case fact
		case forecasts
	}
}

struct Fact: Decodable {
	let temp: Int?
	let feelsLike: Int?
	let icon: Icon?
	let condition: Condition?
	
	enum CodingKeys: String, CodingKey {
		case temp
		case feelsLike = "feels_like"
		case icon
		case condition
	}
}


enum Icon: String, Codable {
	case bknD      = "bkn_d"
	case bknN      = "bkn_n"
	case iconOvcRa = "ovc_-ra"
	case ovc       = "ovc"
	case ovcRa     = "ovc_ra"
	case ovcRaSn   = "ovc_ra_sn"
	case skcD      = "skc_d"
	case skcN      = "skc_n"
}

enum Condition: String, Decodable {
	case clear = "clear"
	case partlyCloudy = "partly-cloudy"
	case cloudy = "cloudy"
	case overcast = "overcast"
	case drizzle = "drizzle"
	case lightRain = "light-rain"
	case rain = "rain"
	case moderateRain = "moderate-rain"
	case heavyRain = "heavy-rain"
	case continuousHeavyRain = "continuous-heavy-rain"
	case showers = "showers"
	case wetSnow = "wet-snow"
	case lightSnow = "light-snow"
	case snow = "snow"
	case snowShowers = "snow-showers"
	case hail = "hail"
	case thunderstorm = "thunderstorm"
	case thunderstormWithRain = "thunderstorm-with-rain"
	case thunderstormWithHail = "thunderstorm-with-hail"
}

struct Forecast: Decodable {
	let parts: Parts?
	let hours: [Hour]?
}

struct Hour: Decodable {
	let temp: Int?
	let feelsLike: Int?
	let condition: Condition?
	let icon: Icon?
	
	enum CodingKeys: String, CodingKey {
		case temp
		case feelsLike = "feels_like"
		case icon
		case condition
	}
}

struct Parts: Decodable {
	let day: Day?
}

struct Day: Decodable {
	let icon: Icon?
	let condition: Condition?
	let feelsLike: Int?
	let temp: Int?
	
	enum CodingKeys: String, CodingKey {
		case icon
		case condition
		case feelsLike = "feels_like"
		case temp
	}
}

struct GeoObject: Decodable {
	let locality: Country?
}

struct Country: Decodable {
	let name: String?
}
