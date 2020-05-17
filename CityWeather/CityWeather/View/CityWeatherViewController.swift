//
//  SecondViewController.swift
//  CityWeather
//
//  Created by Christeena John on 12/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import UIKit

class CityWeatherViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var viewModel: CityWeatherViewModel!
    var cities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAndBindViewModel()
        pageControl.numberOfPages = cities.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func configureAndBindViewModel() {
        guard cities.count > 0 else {
            return
        }
        
        viewModel = CityWeatherViewModel()
        viewModel.cities = cities
        viewModel.configureCellViewModel(city: cities[0])
        
        viewModel.reloadTableClosure = { [weak self] in
            if let indexPaths = self?.collectionView.indexPathsForVisibleItems {
               self?.collectionView.reloadItems(at: indexPaths)
            }
        }
    }
}

extension CityWeatherViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.kWeatherDeatilsCell, for: indexPath) as! WeatherDetailsCell
        if indexPath.row < cities.count {
            let city = cities[indexPath.row]
            let cellModel = viewModel.getCellViewForCity(city)
            cell.updateCellWithModel(cellModel)
        }
        return cell
    }
}

extension CityWeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width,
                      height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cities.count > indexPath.row + 1 {
            let nextIndex = indexPath.row + 1
            viewModel.configureCellViewModel(city: cities[nextIndex])
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        pageControl.currentPage = currentPage
    }

}

