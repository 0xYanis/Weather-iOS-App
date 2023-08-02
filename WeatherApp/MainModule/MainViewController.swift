//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Yan Rybkin on 14.03.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?
    
    private lazy var tableView = WeatherTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
}

extension MainViewController: MainViewProtocol {
    
    func succes() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        alert(message: error.localizedDescription)
    }
    
}

private extension MainViewController {
    
    func initialize() {
        navigationItem.rightBarButtonItem = makeRightBarButtonItem
        createTableView()
    }
    
    func createTableView() {
        tableView.delegate = self
        tableView.presenter = presenter
        tableView.backgroundView = GradientViewFactory.makeGradientView(
            frame: view.frame,
            UIColor.topGradientColor,
            UIColor.BottomGradientColor
        )
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func alert(message: String) {
        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    var makeRightBarButtonItem: UIBarButtonItem {
        let button = UIBarButtonItem(
            title: nil,
            image: UIImage(systemName: "plus.circle.fill"),
            target: self,
            action: nil,
            menu: makeDropDownMenu
        )
        button.tintColor = .white
        button.accessibilityIdentifier = "addBarButtonItem"
        return button
    }
    
    var makeDropDownMenu: UIMenu {
        let newLocItem = UIAction(
            title: "Set new location?",
            image: UIImage(systemName: "mappin.and.ellipse")
        ) { [weak self] _ in
            self?.showNewLocationActionSheet()
        }
        newLocItem.accessibilityIdentifier = "newLocItem"
        return UIMenu(children: [newLocItem])
    }

    func showNewLocationActionSheet() {
        let actionSheet = UIAlertController(
            title: " ",
            message: nil,
            preferredStyle: .actionSheet
        )
        actionSheet.view.addSubview(textField)
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(okAction)

        self.present(actionSheet, animated: true)
    }

    var okAction: UIAlertAction {
        let okAction = UIAlertAction(
            title: "OK",
            style: .default) { [weak self] _ in
            guard let self = self else { return }
            let address = self.textField.text ?? ""
            self.presenter?.setLocation(adress: address)
            self.presenter?.getForecast(adress: address)
            self.textField.removeFromSuperview()
        }
        okAction.accessibilityIdentifier = "okAction"
        return okAction
    }
    
    var cancelAction: UIAlertAction {
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )
        cancelAction.accessibilityIdentifier = "cancelAction"
        return cancelAction
    }
    
    
    var textField: UITextField {
        let textField = UITextField(
            frame: CGRect(
                x: 8, y: 8,
                width: 250,
                height: 30
            )
        )
        textField.placeholder = "Enter Location here"
        textField.accessibilityIdentifier = "locationTextField"
        return textField
    }
    
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        switch indexPath.row {
        case 0:
            return self.calculateHeight(multiply: 1.89)
        case 1:
            return self.calculateHeight(multiply: 5.6)
        default:
            return self.calculateHeight(multiply: 3.27)
        }
    }
    
    private func calculateHeight(multiply: CGFloat) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let safe = view.safeAreaInsets
        let tableСellHeight = screenHeight - safe.top - safe.bottom
        return tableСellHeight / multiply
    }
    
}
