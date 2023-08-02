//
//  WeatherTableView.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 15.06.2023.
//

import UIKit
import SnapKit

protocol TableCellProtocol: UITableViewCell {
    static var cellId: String { get }
}

final class WeatherTableView: UITableView {
    
    weak var presenter: MainPresenterProtocol?
    
    typealias animation = CollectionViewAnimation
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
}

private extension WeatherTableView {
    
    func initialize() {
        createTableView()
        tableViewRegister()
    }
    
    func createTableView() {
        backgroundColor = .clear
        isScrollEnabled = false
        dataSource = self
        separatorColor = .clear
    }
    
    func tableViewRegister() {
        register(TodaysWeatherSetCell.self)
        register(HourlyWeatherSetCell.self)
        register(WeeklyWeatherSetCell.self)
    }
    
    func register<C: TableCellProtocol>(_ cell: C.Type) {
        register(C.self, forCellReuseIdentifier: cell.cellId)
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
            let cell = dequeue(TodaysWeatherSetCell.self, tableView, indexPath)
            cell.configure(with: weather, today: presenter?.todayString ?? "")
            animation.animateReloadData(collectionView: cell.collectionView)
            return cell
        case 1:
            let cell = dequeue(HourlyWeatherSetCell.self, tableView, indexPath)
            cell.configure(with: presenter?.weather?.forecasts?[indexPath.row - 1].hours ?? [],
                           timeArray: presenter?.timeArray ?? [])
            animation.animateReloadData(collectionView: cell.collectionView)
            return cell
        default:
            let cell = dequeue(WeeklyWeatherSetCell.self, tableView, indexPath)
            cell.configure(with: weather.forecasts ?? [],
                           dateArray: presenter?.dateArray ?? [])
            cell.accessibilityIdentifier = "WeeklyWeatherSetCell"
            animation.animateReloadData(collectionView: cell.collectionView)
            return cell
        }
    }
    
    private func dequeue<C: TableCellProtocol>(
        _ cell: C.Type,
        _ tableView: UITableView,
        _ indexPath: IndexPath
    ) -> C {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cell.cellId,
            for: indexPath
        ) as! C
        return cell
    }
    
}
