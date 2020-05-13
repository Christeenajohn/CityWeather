//
//  FirstViewController.swift
//  CityWeather
//
//  Created by Christeena John on 12/05/2020.
//  Copyright © 2020 Christeena John. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextView!
    @IBOutlet weak var findButton: UIButton!
    private var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
        inputField.delegate = self
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: Private methods
    private func configureViewModel() {
        viewModel = HomeViewModel()
        
        viewModel.updateUIForValidInput = { [unowned self] (isValid) in
            self.findButton.isSelected = isValid
        }
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    //MARK: Action methods
    @IBAction func didTapFindWeather(_ sender: Any) {
        
        if viewModel.canFindWeather == true {
            let cityWeatherVC = storyboard?.instantiateViewController(identifier: StoryBoardID.kCityWeatherController) as! CityWeatherViewController
            cityWeatherVC.cities = viewModel.cities
            navigationController?.pushViewController(cityWeatherVC, animated: true)
            
        } else {
            showAlert(ErrorMessages.invalidCity, presenter: self)
        }
    }
}

extension HomeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        viewModel.input = textView.text
    }
}

