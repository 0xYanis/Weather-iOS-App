//
//  LocationService.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 16.03.2023.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol: AnyObject {
    typealias completionBlock = ([Double]?) -> Void
	func getUserLocation(from address: String, completion: @escaping completionBlock)
}

class LocationService {
	let geocoder = CLGeocoder()
}

extension LocationService: LocationServiceProtocol {
    
    typealias completionBlock = ([Double]?) -> Void
    
	func getUserLocation(from address: String, completion: @escaping completionBlock) {
		geocoder.geocodeAddressString(address) { placemarks, error in
			guard let placemark = placemarks?.first, error == nil else {
                completion(nil); return
			}
			let latitude = placemark.location?.coordinate.latitude ?? 0.0
			let longitude = placemark.location?.coordinate.longitude ?? 0.0
            
			completion([latitude, longitude])
		}
	}
    
}
