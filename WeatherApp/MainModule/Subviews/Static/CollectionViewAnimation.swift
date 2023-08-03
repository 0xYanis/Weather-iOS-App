//
//  CollectionViewAnimation.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 18.03.2023.
//

import UIKit

final class CollectionViewAnimation {
	
	static func animateReloadData(collectionView: UICollectionView) {
		UIView.animate(withDuration: 0.0, animations: {
			collectionView.alpha = 0
		}, completion: { _ in
			collectionView.reloadData()
			UIView.animate(withDuration: 0.3) {
				collectionView.alpha = 1
			}
		})
	}
    
}
