//
//  WeatherTableView.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 15.06.2023.
//

import UIKit
import SnapKit

final class WeatherTableView: UITableView {
    
    weak var presenter: MainPresenterProtocol?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WeatherTableView {
    func initialize() {
        
    }
    
    func createTableView() {
        backgroundColor = .clear
        isScrollEnabled = false
        dataSource = self
        separatorColor = .clear
    }
    
    func tableViewRegister() {
        register(
            TodaysWeatherSetCell.self,
            forCellReuseIdentifier: TodaysWeatherSetCell.cellId
        )
        register(
            HourlyWeatherSetCell.self,
            forCellReuseIdentifier: HourlyWeatherSetCell.cellId
        )
        
        register(
            WeeklyWeatherSetCell.self,
            forCellReuseIdentifier: WeeklyWeatherSetCell.cellId
        )
    }
    
    
}


// MARK: - UITableViewDataSource
extension WeatherTableView: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 3
    }
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let weather = presenter?.weather else {
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TodaysWeatherSetCell.cellId,
                for: indexPath
            ) as! TodaysWeatherSetCell
            cell.configure(with: weather, today: presenter?.todayString ?? "")
            CollectionViewAnimation.animateReloadData(collectionView: cell.collectionView)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HourlyWeatherSetCell.cellId,
                for: indexPath
            ) as! HourlyWeatherSetCell
            cell.configure(with: presenter?.weather?.forecasts?[indexPath.row - 1].hours ?? [],
                           timeArray: presenter?.timeArray ?? []
            )
            CollectionViewAnimation.animateReloadData(collectionView: cell.collectionView)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WeeklyWeatherSetCell.cellId,
                for: indexPath
            ) as! WeeklyWeatherSetCell
            cell.configure(with: weather.forecasts ?? [],
                           dateArray: presenter?.dateArray ?? []
            )
            cell.accessibilityIdentifier = "WeeklyWeatherSetCell"
            CollectionViewAnimation.animateReloadData(collectionView: cell.collectionView)
            return cell
        }
    }
}
