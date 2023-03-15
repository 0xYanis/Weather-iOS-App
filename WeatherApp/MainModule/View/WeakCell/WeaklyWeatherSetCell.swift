//
//  WeaklyWeatherSetCell.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 14.03.2023.
//

import UIKit

class WeaklyWeatherSetCell: UITableViewCell {
	
	// MARK: - Public
	func configure() {
		
	}
	
	// MARK: - Init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initialize()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Private Constants
	private enum UIConstants {
		static let cellWidth: CGFloat             = 120
		static let cellHeight: CGFloat            = 180
		static let forecastLabelFontSize: CGFloat = 18
		static let forecastLabelInset: CGFloat    = 16
	}
	
	// MARK: - Private properties
	private let forecastLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Helvetica", size: UIConstants.forecastLabelFontSize)
		label.text = "7 days forecast"
		label.textColor = .white
		return label
	}()
	private var collectionView: UICollectionView!
}

// MARK: - Private methods
private extension WeaklyWeatherSetCell {
	func initialize() {
		backgroundColor = .clear
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 20
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(WeaklyWeatherBarElements.self, forCellWithReuseIdentifier: String(describing: WeaklyWeatherBarElements.self))
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
		// MARK: - DELETE BACKGROUND COLOR
		collectionView.backgroundColor = nil
		collectionView.contentInset = .init(top: 20, left: 16, bottom: 0, right: 16)
	}
}

// MARK: - UICollectionViewDataSource
extension WeaklyWeatherSetCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 7
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WeaklyWeatherBarElements.self), for: indexPath) as! WeaklyWeatherBarElements
		cell.backgroundColor = UIColor.BarColor
		cell.layer.cornerRadius = 15
		cell.layer.shadowOpacity = 0.15
		cell.layer.shadowOffset = CGSize(width: 0, height: 2)
		cell.layer.shadowRadius = 4.0
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WeaklyWeatherSetCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: UIConstants.cellWidth, height: UIConstants.cellHeight)
	}
}
