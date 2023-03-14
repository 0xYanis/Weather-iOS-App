//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 14.03.2023.
//

import UIKit

class MainViewController: UIViewController {
	
	var presenter: MainPresenterProtocol!
	
	//MARK: VC lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		initialize()
	}
}

extension MainViewController: MainViewProtocol {
	func setLocation(location: String) {
		//
	}
	
	func setAnotherForecast(dayNumber: Int) {
		//
	}
	
	
}

// MARK: Private methods
private extension MainViewController {
	func initialize() {
		
	}
}
