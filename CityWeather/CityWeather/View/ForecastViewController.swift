//
//  ForecastViewController.swift
//  CityWeather
//
//  Created by Christeena John on 13/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import Foundation
import UIKit

class ForecastViewController: UIViewController {
    private struct Constants {
        static let cellHeight: CGFloat = 70.0
    }
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var forecastTable: UITableView!
    @IBOutlet weak var locationErrorLabel: UILabel!
      @IBOutlet weak var locationErrorHolder: UIView!
    
    private var selectedSection = 0
    private var viewModel: ForecastViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAndBindViewModel()
        
        forecastTable.rowHeight = UITableView.automaticDimension
        forecastTable.estimatedRowHeight = Constants.cellHeight
    }
    
    private func configureAndBindViewModel() {
        viewModel = ForecastViewModel()
        
        viewModel.reloadClosure = { [weak self] in
            self?.locationErrorHolder.isHidden = true
            self?.forecastTable.reloadData()
        }
        
        viewModel.updateCurrentLocation = { [weak self] (city) in
            self?.cityLabel.text = city
        }
        
        viewModel.updateLoadingStatus = { [weak self] (isFectching) in
            if (isFectching == true) {
                self?.loader.startAnimating()
            } else {
                self?.loader.stopAnimating()
            }
        }
        
        viewModel.updateLocationAccessStatus = { [weak self] (isAccessible) in
            if let self = self, isAccessible == false {
                showAlert(CWErrorMessages.locationPermissionError, presenter: self)
                
                self.locationErrorLabel.text = CWErrorMessages.locationPermissionError
                self.locationErrorHolder.isHidden = false
            }
        }
    }
}

extension ForecastViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dates.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let sectionKey = viewModel.dates[section]
        return (section == selectedSection) ? viewModel.cellModels[sectionKey]!.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.kForecastDateCell) as! ForecaseDateCell
                cell.dateLabel.text = viewModel.dates[indexPath.section].getDate()?.getDateDisplayString()
                return cell
            default:
                guard let cellVM = viewModel
                    .getCellViewModelFor(row: indexPath.row-1,
                                         date: viewModel.dates[indexPath.section]) else {
                                            return UITableViewCell()
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.kForeCastCell) as! ForecastCell
                cell.updateDataWith(cellVM)
                return cell
        }
    }
}


extension ForecastViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        selectedSection = indexPath.section
        tableView.reloadData()
    }
}




