//
//  HourlyWeatherBarElements.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 14.03.2023.
//

import UIKit

class HourlyWeatherBarElements: UICollectionViewCell {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Private constants
	private enum UIConstants {
		static let labelToCellInset: CGFloat = 5
		static let timeLabelFontSize: CGFloat = 14
		static let imageViewSize: CGFloat = 50
		static let imageViewToTimeOffset: CGFloat = 8
	}
	
	// MARK: - Private properties
	private let timeLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Helvetica-Bold", size: UIConstants.timeLabelFontSize)
		label.text = "Now"
		label.textColor = .white
		return label
	}()
	
	private let imageView: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "cloud")
		view.contentMode = .scaleAspectFill
		return view
	}()
	
	private let temperatureLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	private let degreeLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
}

// MARK: - Private methods
private extension HourlyWeatherBarElements {
	func initialize() {
		contentView.addSubview(timeLabel)
		timeLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.centerX.equalToSuperview()
		}
		contentView.addSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.top.equalTo(timeLabel.snp.bottom).offset(UIConstants.imageViewToTimeOffset)
			make.centerX.equalToSuperview()
			make.height.equalTo(UIConstants.imageViewSize)
			make.width.equalTo(UIConstants.imageViewSize)
		}
	}
}
