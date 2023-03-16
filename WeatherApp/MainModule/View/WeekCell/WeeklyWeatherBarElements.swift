//
//  WeeklyWeatherBarElements.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 15.03.2023.
//

import UIKit

class WeeklyWeatherBarElements: UICollectionViewCell {
	
	func configure(with dayWeather: Forecast, date: String) {
		dayLabel.text = date
		imageView.image = UIImage(named: dayWeather.parts?.day?.condition?.rawValue ?? "")
		temperatureLabel.text = String(describing: dayWeather.parts?.day?.feelsLike ?? 0)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Private constants
	private enum UIConstants {
		static let dayLabelFontSize: CGFloat              = 14
		static let dayLabelInset: CGFloat                 = 20
		static let imageViewToDayOffset: CGFloat          = 10
		static let imageViewSize: CGFloat                 = 75
		static let temperatureLabelFontSize: CGFloat      = 28
		static let temperatureLabelToImageOffset: CGFloat = 10
	}
	
	// MARK: - Private properties
	private let dayLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Helvetica", size: UIConstants.dayLabelFontSize)
		label.textColor = .white
		return label
	}()
	
	private let imageView: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFill
		return view
	}()
	
	private let temperatureLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Helvetica-Bold", size: UIConstants.temperatureLabelFontSize)
		label.textColor = .white
		label.layer.shadowColor = UIColor.black.cgColor
		label.layer.shadowOffset = CGSize(width: 0, height: 3)
		label.layer.shadowRadius = 5
		label.layer.shadowOpacity = 0.5
		label.layer.masksToBounds = false
		return label
	}()
}

// MARK: - Private methods
private extension WeeklyWeatherBarElements {
	func initialize() {
		backgroundColor = UIColor.BarColor
		layer.cornerRadius = 15
		layer.shadowOpacity = 0.15
		layer.shadowOffset = CGSize(width: 0, height: 2)
		layer.shadowRadius = 4.0
		contentView.addSubview(dayLabel)
		dayLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalToSuperview().inset(UIConstants.dayLabelInset)
		}
		contentView.addSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.top.equalTo(dayLabel.snp.bottom).offset(UIConstants.imageViewToDayOffset)
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
