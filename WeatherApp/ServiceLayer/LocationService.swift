//
//  LocationService.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 16.03.2023.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol: AnyObject {
	func getUserLocation(from address: String, completion: @escaping ([Double]?) -> Void)
}

class LocationService: NSObject {
	let geocoder = CLGeocoder()
}

extension LocationService: LocationServiceProtocol {
	func getUserLocation(from address: String, completion: @escaping ([Double]?) -> Void) {
		geocoder.geocodeAddressString(address) { placemarks, error in
			guard let placemark = placemarks?.first, error == nil else {
				completion(nil)
				return
			}
			let latitude = placemark.location?.coordinate.latitude ?? 0
			let longitude = placemark.location?.coordinate.longitude ?? 0
			completion([latitude, longitude])
		}
	}
}
