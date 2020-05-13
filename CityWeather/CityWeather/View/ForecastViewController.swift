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
    
    private var viewModel: ForecastViewModel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var forecastTable: UITableView!
    private var selectedSection = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }
    
    private func configureViewModel() {
        viewModel = ForecastViewModel()
        
        viewModel.reloadClosure = { [weak self] in
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
                showAlert(ErrorMessages.locationPermissionError, presenter: self)
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
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.kForecastDateCell) as! ForecaseDateCell
            cell.dateLabel.text = viewModel.dates[indexPath.section].getDate()?.getDateDisplayString()
            
            return cell
            
        } else {
            if let cellVM = viewModel.getCellViewModelFor(row: indexPath.row-1,
                                    date: viewModel.dates[indexPath.section]) {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.kForeCastCell) as! ForecastCell
                cell.updateDataWith(cellVM)
                return cell
            }
            
            return UITableViewCell()
        }
    }
    
}


extension ForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        selectedSection = indexPath.section
        tableView.reloadData()
    }
}


