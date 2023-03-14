//
//  HourlyWeatherSetCell.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 14.03.2023.
//

import UIKit

class HourlyWeatherSetCell: UITableViewCell {
	
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
		static let collectionViewHeight: CGFloat = 150
		static let cellWidth: CGFloat            = 55
		static let cellHeight: CGFloat           = 100
	}
	
	// MARK: - Private properties
	private var collectionView: UICollectionView!
	
}

// MARK: - Private methods
private extension HourlyWeatherSetCell {
	func initialize() {
		backgroundColor = .green
		let layout = UICollectionViewFlowLayout()
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(HourlyWeatherBarElements.self, forCellWithReuseIdentifier: String(describing: HourlyWeatherBarElements.self))
		collectionView.dataSource = self
		collectionView.delegate = self
		contentView.addSubview(collectionView)
		collectionView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
			make.height.equalTo(UIConstants.collectionViewHeight)
		}
		// MARK: - DELETE BACKGROUND COLOR
		collectionView.backgroundColor = nil
	}
}

// MARK: - UICollectionViewDataSource
extension HourlyWeatherSetCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HourlyWeatherBarElements.self), for: indexPath) as! HourlyWeatherBarElements
		cell.backgroundColor = .red
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HourlyWeatherSetCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: UIConstants.cellWidth, height: UIConstants.cellHeight)
	}
}
