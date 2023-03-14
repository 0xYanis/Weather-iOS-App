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
		static let timeLabelFontSize: CGFloat             = 12
		static let imageViewSize: CGFloat                 = 40
		static let imageViewToTimeOffset: CGFloat         = 10
		static let temperatureLabelFontSize: CGFloat      = 20
		static let temperatureLabelToImageOffset: CGFloat = 5
	}
	
	// MARK: - Private properties
	private let timeLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Helvetica", size: UIConstants.timeLabelFontSize)
		label.text = "9:00 AM"
		label.textColor = .white
		return label
	}()
	
	private let imageView: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "rainycloud")
		view.contentMode = .scaleAspectFill
		return view
	}()
	
	private let temperatureLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Helvetica-Bold", size: UIConstants.temperatureLabelFontSize)
		label.text = "10" + "\u{00B0}"
		label.textColor = .white
		label.layer.shadowColor = UIColor.black.cgColor
		label.layer.shadowOffset = CGSize(width: 0, height: 3)
		label.layer.shadowRadius = 5
		label.layer.shadowOpacity = 0.5
		label.layer.masksToBounds = false
		return label
	}()
	
	private let degreeLabel: UILabel = {
		let label = UILabel()
		//
		label.text = "\u{00B0}"
		label.textColor = .white
		label.layer.shadowColor = UIColor.black.cgColor
		label.layer.shadowOffset = CGSize(width: 0, height: 3)
		label.layer.shadowRadius = 2
		label.layer.shadowOpacity = 0.5
		label.layer.masksToBounds = false
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
		contentView.addSubview(temperatureLabel)
		temperatureLabel.snp.makeConstraints { make in
			make.top.equalTo(imageView.snp.bottom).offset(UIConstants.temperatureLabelToImageOffset)
			make.centerX.equalToSuperview()
		}
	}
}
