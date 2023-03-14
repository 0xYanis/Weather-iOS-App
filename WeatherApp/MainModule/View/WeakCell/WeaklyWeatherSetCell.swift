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
		static let collectionViewHeight: CGFloat = 180
		static let cellWidth: CGFloat            = 120
		static let cellHeight: CGFloat           = 180
	}
	
	// MARK: - Private properties
	private var collectionView: UICollectionView!
	
}

// MARK: - Private methods
private extension WeaklyWeatherSetCell {
	func initialize() {
		backgroundColor = .clear
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isScrollEnabled = true
		contentView.insertSubview(collectionView, at: 0)
		collectionView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
			make.height.equalTo(UIConstants.collectionViewHeight)
		}
		// MARK: - DELETE BACKGROUND COLOR
		collectionView.backgroundColor = nil
		collectionView.contentInset = .init(top: 10, left: 16, bottom: 0, right: 16)
	}
}

// MARK: - UICollectionViewDataSource
extension WeaklyWeatherSetCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 7
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
		cell.backgroundColor = .red
		cell.layer.cornerRadius = 15
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WeaklyWeatherSetCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: UIConstants.cellWidth, height: UIConstants.cellHeight)
	}
}
