//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 14.03.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
	
	var presenter: MainPresenterProtocol!
	
	//MARK: VC lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		initialize()
	}
	
	// MARK: - Private properties
	private let tableView = UITableView()
	
}

extension MainViewController: MainViewProtocol {
	func setLocation(location: String) { }
	
	func setAnotherForecast(dayNumber: Int) { }
}

// MARK: Private methods
private extension MainViewController {
	func initialize() {
		navigationItem.rightBarButtonItem = makeRightBarButtonItem()
		tableView.backgroundColor = .clear
		tableView.isScrollEnabled = false
		tableView.dataSource = self
		tableView.delegate = self
		tableView.separatorColor = .clear
		tableView.register(TodaysWeatherSetCell.self, forCellReuseIdentifier: String(describing: TodaysWeatherSetCell.self))
		tableView.register(HourlyWeatherSetCell.self, forCellReuseIdentifier: String(describing: HourlyWeatherSetCell.self))
		tableView.register(WeaklyWeatherSetCell.self, forCellReuseIdentifier: String(describing: WeaklyWeatherSetCell.self))
		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		tableView.backgroundView = backgroundGradient(view.bounds, UIColor.topGradientColor, UIColor.BottomGradientColor)
	}
	
	func backgroundGradient(_ bounds: CGRect,_ topColor: UIColor,_ bottomColor: UIColor) -> UIView {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = bounds
		gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
		gradientLayer.locations = [0.0, 1.0]
		gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
		gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
		let gradientView = UIView(frame: bounds)
		gradientView.layer.insertSublayer(gradientLayer, at: 0)
		return gradientView
	}
	
	
	func makeRightBarButtonItem() -> UIBarButtonItem {
		let addBarButtonItem = UIBarButtonItem(title: nil,
											  image: UIImage(systemName: "plus.circle.fill"),
											  target: self,
											  action: nil,
											  menu: makeDropDownMenu())
		addBarButtonItem.tintColor = .white
		return addBarButtonItem
	}
	
	func makeDropDownMenu() -> UIMenu {
		let newLocItem = UIAction(title: "New location", image: UIImage(systemName: "mappin.and.ellipse")) { _ in
			
		}
		return UIMenu(children: [newLocItem])
	}
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TodaysWeatherSetCell.self), for: indexPath) as! TodaysWeatherSetCell
			return cell
		} else if indexPath.row == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HourlyWeatherSetCell.self), for: indexPath) as! HourlyWeatherSetCell
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeaklyWeatherSetCell.self), for: indexPath) as! WeaklyWeatherSetCell
			return cell
		}
	}
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.row {
		case 0:
			return self.calculateHeight(multiplier: 1.89)
		case 1:
			return self.calculateHeight(multiplier: 5.6)
		default:
			return self.calculateHeight(multiplier: 3.27)
		}
	}
	private func calculateHeight(multiplier: CGFloat) -> CGFloat {
		let screenHeight = UIScreen.main.bounds.height
		let tableСellHeight = screenHeight - view.safeAreaInsets.top - view.safeAreaInsets.bottom
		return tableСellHeight / multiplier
	}
}
