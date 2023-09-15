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

final class ModuleBuilder: Builder {
	static func createMainModule() -> UIViewController {
        let mainService = MainService()
		let view = MainViewController()
		let presenter = MainPresenter(
            view: view,
            mainService: mainService)
		view.presenter = presenter
        
		return view
	}
}
