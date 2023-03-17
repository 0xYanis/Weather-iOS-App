//
//  LocationService.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 16.03.2023.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol: AnyObject {
	func getUserLocation() -> [Double]?
}

class LocationService: NSObject {
	let manager = CLLocationManager()
	var latitude: Double = 0
	var longitude: Double = 0
}

extension LocationService: LocationServiceProtocol {
	func getUserLocation() -> [Double]? {
		manager.requestWhenInUseAuthorization()
		manager.delegate = self
		manager.startUpdatingLocation()
		return [latitude, longitude]
	}
}

extension LocationService: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			self.latitude = location.coordinate.latitude
			self.longitude = location.coordinate.longitude
			manager.stopUpdatingLocation()
		}
	}
}
