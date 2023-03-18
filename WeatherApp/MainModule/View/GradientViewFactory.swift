//
//  GradientViewFactory.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 18.03.2023.
//

import UIKit

class GradientViewFactory {
	static func makeGradientView(frame: CGRect,_ topColor: UIColor,_ bottomColor: UIColor) -> UIView {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = frame
		gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
		gradientLayer.locations = [0.0, 1.0]
		gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
		gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
		let gradientView = UIView(frame: frame)
		gradientView.layer.insertSublayer(gradientLayer, at: 0)
		return gradientView
	}
}
