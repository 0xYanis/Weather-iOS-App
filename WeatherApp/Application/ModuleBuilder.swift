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
		let model = Model(lat: 1.0, lon: 2.0, timezone: "USA", timezoneOffset: -10, current: nil)
		let view = MainViewController()
		let presenter = MainPresenter(view: view, model: model)
		view.presenter = presenter
		return view
	}
}
