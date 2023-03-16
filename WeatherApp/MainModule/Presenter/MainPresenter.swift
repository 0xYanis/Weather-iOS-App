//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 14.03.2023.
//

import Foundation

// MARK: OUTPUT Protocol
protocol MainViewProtocol: AnyObject {
	func succes()
	func failure(error: Error)
}

// MARK: INPUT Protocol
protocol MainPresenterProtocol: AnyObject {
	init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
	func getForecast()
	func getTimeArray() -> [String]
	var timeArray: [String]? { get set }
	var weather: Weather? { get set }
}

class MainPresenter: MainPresenterProtocol {
	
	var weather: Weather?
	var timeArray: [String]?
	weak var view: MainViewProtocol?
	let networkService: NetworkServiceProtocol!
	
	required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
		self.view = view
		self.networkService = networkService
		getForecast()
	}
	
	func getForecast() {
		networkService.getForecast { [weak self] result in
			guard let self = self else { return }
			DispatchQueue.main.async {
				switch result {
				case .success(let weather):
					self.weather = weather
					self.timeArray = self.getTimeArray()
					self.view?.succes()
				case .failure(let error):
					self.view?.failure(error: error)
				}
			}
		}
	}
	
	func getTimeArray() -> [String] {
		
		var timeArray = [String]()
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "h:00 a"
		timeArray.append("NOW")
		
		for i in 1...4 {
			if let date = Calendar.current.date(byAdding: .hour, value: i, to: Date()) {
				timeArray.append(dateFormatter.string(from: date))
			}
		}
		return timeArray
	}
}
