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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initialize()
	}
	
	private let tableView = UITableView()
	
}

extension MainViewController: MainViewProtocol {
	func succes() {
		tableView.reloadData()
	}
	
	func failure(error: Error) {
		alert(message: error.localizedDescription)
	}
}

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
		tableView.register(WeeklyWeatherSetCell.self, forCellReuseIdentifier: String(describing: WeeklyWeatherSetCell.self))
		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		tableView.backgroundView = GradientViewFactory.makeGradientView(frame: view.frame, UIColor.topGradientColor, UIColor.BottomGradientColor)
	}
	
	func alert(message: String) {
		let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		alertController.addAction(okAction)
		present(alertController, animated: true, completion: nil)
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
		let newLocItem = UIAction(title: "Set new location?", image: UIImage(systemName: "mappin.and.ellipse")) { [weak self] _ in
			guard let self = self else { return }
			let actionSheet = UIAlertController(title: " ", message: nil, preferredStyle: .actionSheet)
			
			let textField = UITextField(frame: CGRect(x: 8, y: 8, width: 250, height: 30))
			textField.placeholder = "Enter Location here"
			actionSheet.view.addSubview(textField)
			
			let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
			actionSheet.addAction(cancelAction)
			
			let okAction = UIAlertAction(title: "OK", style: .default) { [weak self, weak actionSheet] _ in
				guard let self = self, let actionSheet = actionSheet else { return }
				let adress = textField.text ?? ""
				self.presenter.setLocation(adress: adress)
				self.presenter.getForecast(adress: adress)
				textField.removeFromSuperview()
				actionSheet.dismiss(animated: true, completion: nil)
			}
			actionSheet.addAction(okAction)
			
			self.present(actionSheet, animated: true)
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
		guard let weather = presenter.weather else {
			let cell = UITableViewCell()
			cell.backgroundColor = .clear
			return cell
		}
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TodaysWeatherSetCell.self), for: indexPath) as! TodaysWeatherSetCell
			cell.configure(with: weather, today: presenter.todayString ?? "")
			CollectionViewAnimation.animateReloadData(collectionView: cell.collectionView)
			return cell
		}
		if indexPath.row == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HourlyWeatherSetCell.self), for: indexPath) as! HourlyWeatherSetCell
			cell.configure(with: presenter.weather?.forecasts?[indexPath.row - 1].hours ?? [], timeArray: presenter.timeArray ?? [])
			CollectionViewAnimation.animateReloadData(collectionView: cell.collectionView)
			return cell
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeeklyWeatherSetCell.self), for: indexPath) as! WeeklyWeatherSetCell
		cell.configure(with: weather.forecasts ?? [], dateArray: presenter.dateArray ?? [])
		CollectionViewAnimation.animateReloadData(collectionView: cell.collectionView)
		return cell
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
