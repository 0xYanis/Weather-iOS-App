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
		tableView.dataSource = self
		tableView.separatorColor = .clear
		tableView.register(TodaysWeatherSetCell.self, forCellReuseIdentifier: String(describing: TodaysWeatherSetCell.self))
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "111")
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "222")
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
		let addBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
											   style: .plain,
											   target: self,
											   action: #selector(didTapPlusButton))
		addBarButtonItem.tintColor = .white
		return addBarButtonItem
	}
	
	@objc func didTapPlusButton() { }
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
			let cell = tableView.dequeueReusableCell(withIdentifier: "111", for: indexPath)
			cell.backgroundColor = .blue
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "222", for: indexPath)
			cell.backgroundColor = .yellow
			return cell
		}
	}
}
