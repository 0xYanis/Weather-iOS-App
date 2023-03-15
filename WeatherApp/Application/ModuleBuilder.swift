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
		let networkService = NetworkService()
		let presenter = MainPresenter(view: view, networkService: networkService)
		view.presenter = presenter
		return view
	}
}
