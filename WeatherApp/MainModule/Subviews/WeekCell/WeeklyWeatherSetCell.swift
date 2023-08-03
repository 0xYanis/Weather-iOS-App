//
//  WeeklyWeatherSetCell.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 14.03.2023.
//

import UIKit

final class WeeklyWeatherSetCell: UITableViewCell, TableCellProtocol {
	
    static let cellId = "WeeklyWeatherSetCell"
    
    private let forecastLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: UIConstants.forecastLabelFontSize)
        label.text = "7 days forecast"
        label.textColor = .white
        return label
    }()
    internal var collectionView: UICollectionView!
    private var weeksWeather: [Forecast]!
    private var dateArray: [String] = []
    
	func configure(with weeksWeather: [Forecast], dateArray: [String]) {
		self.weeksWeather = weeksWeather
		self.dateArray = dateArray
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initialize()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private enum UIConstants {
		static let cellWidth: CGFloat             = 120
		static let cellHeight: CGFloat            = 180
		static let forecastLabelFontSize: CGFloat = 18
		static let forecastLabelInset: CGFloat    = 16
	}
}

private extension WeeklyWeatherSetCell {
	func initialize() {
		backgroundColor = .clear
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 20
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(WeeklyWeatherBarElements.self, forCellWithReuseIdentifier: String(describing: WeeklyWeatherBarElements.self))
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.showsHorizontalScrollIndicator = false
		contentView.insertSubview(collectionView, at: 0)
		collectionView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		contentView.insertSubview(forecastLabel, at: 0)
		forecastLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview().inset(UIConstants.forecastLabelInset)
		}
		collectionView.backgroundColor = nil
		collectionView.contentInset = .init(top: 20, left: 16, bottom: 0, right: 16)
	}
}

// MARK: - UICollectionViewDataSource
extension WeeklyWeatherSetCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 7
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WeeklyWeatherBarElements.self), for: indexPath) as! WeeklyWeatherBarElements
		cell.configure(with: weeksWeather[indexPath.row], date: dateArray[indexPath.row])
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WeeklyWeatherSetCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: UIConstants.cellWidth, height: UIConstants.cellHeight)
	}
}
