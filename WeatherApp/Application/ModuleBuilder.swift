//
//  ModuleBuilder.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 14.03.2023.
//

import UIKit

protocol Builder {
	static func createMainModule() -> UIViewController
}

class ModuleBuilder: Builder {
	static func createMainModule() -> UIViewController {
		let view = MainViewController()
		let locationService = LocationService()
		let networkService = NetworkService()
		let mainService = MainService(
            networkService: networkService,
            locationService: locationService
        )
        
		let presenter = MainPresenter(
            view: view,
            mainService: mainService
        )
        
		view.presenter = presenter
        
		return view
	}
}
