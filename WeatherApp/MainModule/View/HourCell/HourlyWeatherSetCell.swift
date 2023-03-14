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
		static let collectionViewHeight: CGFloat    = 120
		static let cellWidth: CGFloat               = 55
		static let cellHeight: CGFloat              = 100
		static let barViewToTableViewInset: CGFloat = 16
	}
	
	// MARK: - Private properties
	private var collectionView: UICollectionView!
	private let barView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.HourlyBarColor
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 0.3
		view.layer.shadowOffset = CGSize(width: 0, height: 2)
		view.layer.shadowRadius = 4.0
		view.layer.cornerRadius = 15
		return view
	}()
}

// MARK: - Private methods
private extension HourlyWeatherSetCell {
	func initialize() {
		backgroundColor = .clear
		let layout = UICollectionViewFlowLayout()
		layout.minimumInteritemSpacing = 0
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(HourlyWeatherBarElements.self, forCellWithReuseIdentifier: String(describing: HourlyWeatherBarElements.self))
		collectionView.dataSource = self
		collectionView.delegate = self
		contentView.insertSubview(barView, at: 0)
		barView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(UIConstants.barViewToTableViewInset)
			make.top.bottom.equalToSuperview().inset(UIConstants.barViewToTableViewInset / 2)
		}
		contentView.addSubview(collectionView)
		collectionView.snp.makeConstraints { make in
			make.edges.equalTo(barView.snp.edges)
			make.height.equalTo(UIConstants.collectionViewHeight)
		}
		// MARK: - DELETE BACKGROUND COLOR
		collectionView.backgroundColor = nil
		collectionView.contentInset = .init(top: 12, left: 16, bottom: 0, right: 16)
	}
}

// MARK: - UICollectionViewDataSource
extension HourlyWeatherSetCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HourlyWeatherBarElements.self), for: indexPath) as! HourlyWeatherBarElements
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HourlyWeatherSetCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: UIConstants.cellWidth, height: UIConstants.cellHeight)
	}
}
