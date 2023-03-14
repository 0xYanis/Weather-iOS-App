//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 14.03.2023.
//

import Foundation

// MARK: OUTPUT Protocol
protocol MainViewProtocol: AnyObject {
	func setLocation(location: String)
	func setAnotherForecast(dayNumber: Int)
}

// MARK: INPUT Protocol
protocol MainPresenterProtocol: AnyObject {
	init(view: MainViewProtocol, model: Model)
	func changeLocation()
	func showForecast()
}

class MainPresenter: MainPresenterProtocol {
	
	let view: MainViewProtocol
	let model: Model
	
	required init(view: MainViewProtocol, model: Model) {
		self.view = view
		self.model = model
	}
	
	func changeLocation() { }
	
	func showForecast() { }
	
	
}
