//
//  WeatherPresentModel.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 16.03.2023.
//

import Foundation

struct WeatherPresentModel {
	
	var location: String
	var temperature: Int
	var condition: String
	
	var hourlyTemperature: Int
	var hourlyCondition: String
	
	var weaklyTemperature: Int
	var weaklyCondition: String
	
	var conditionString: String {
		switch condition {
		case "clear":                return "Ясно"
		case "partlyCloudy":         return "Малооблачно"
		case "cloudy":               return "Облачно с прояснениями"
		case "overcast":             return "Пасмурно"
		case "drizzle":              return "Морось"
		case "lightRain":            return "Небольшой дождь"
		case "rain":                 return "Дождь"
		case "moderateRain":         return "Умеренно сильный дождь"
		case "heavyRain":            return "Сильный дождь"
		case "continuousHeavyRain":  return "Длительный сильный дождь"
		case "showers":              return "Ливень"
		case "wetSnow":              return "Дождь со снегом"
		case "lightSnow":            return "Небольшой снег"
		case "snow":                 return "Снег"
		case "snowShowers":          return "Снегопад"
		case "hail":                 return "Град"
		case "thunderstorm":         return "Гроза"
		case "thunderstormWithRain": return "Дождь с грозой"
		case "thunderstormWithHail": return "Гроза с градом"
			
		default: return "Нет данных"
		}
	}
	
//	init(weather: Weather, hours: Hour, parts: Parts) {
//		location = weather.geoObject.locality?.name ?? "Моя Геопозиция"
//		temperature = weather.fact.temp ?? 0
//		condition = weather.fact.condition?.rawValue ?? "Нет данных"
//
//		hourlyTemperature = hours.temp
//		hourlyCondition = hours.condition?.rawValue
//
//		weaklyTemperature = parts.
//		weaklyCondition
//	}
}
