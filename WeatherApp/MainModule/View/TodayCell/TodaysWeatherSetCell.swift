//
//  TodaysWeatherSetCell.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 14.03.2023.
//

import UIKit

class TodaysWeatherSetCell: UITableViewCell {
	
	// MARK: - Public
	func configure(with todaysWeather: Weather) {
		self.todaysWeather = todaysWeather
	}
	
	// MARK: - Init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initialize()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private properties
	private var collectionView: UICollectionView!
	private var todaysWeather: Weather!
}

// MARK: - Private methods
private extension TodaysWeatherSetCell {
	func initialize() {
		backgroundColor = .clear
		let layout = UICollectionViewFlowLayout()
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(TodaysWeatherElements.self, forCellWithReuseIdentifier: String(describing: TodaysWeatherElements.self))
		collectionView.dataSource = self
		contentView.addSubview(collectionView)
		collectionView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		// MARK: - DELETE BACKGROUND COLOR
		collectionView.backgroundColor = nil
	}
}

// MARK: - UICollectionViewDataSource
extension TodaysWeatherSetCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TodaysWeatherElements.self), for: indexPath) as! TodaysWeatherElements
		cell.configure(with: todaysWeather)
		return cell
	}
}
