//
//  WeatherListRouter.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 7/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

import UIKit

protocol WeatherListRouterInput {
    func navigateToWeatherDetails()
}

class WeatherListRouter: WeatherListRouterInput {
    weak var viewController: WeatherListViewController!
    
    // MARK: - Navigation
    
    func navigateToWeatherDetails() {
        viewController.performSegue(withIdentifier: "ShowDetails", sender: nil)
    }
    
    // MARK: - Communication
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        if segue.identifier == "ShowDetails" {
            passDataToWeatherDetails(segue: segue)
        }
    }
    
    func passDataToWeatherDetails(segue: UIStoryboardSegue) {
        let weatherDetailsViewController = segue.destination as! WeatherDetailsViewController
        weatherDetailsViewController.interactor.weatherData = viewController.interactor.selectedWeatherData
        weatherDetailsViewController.interactor.city = viewController.interactor.selectedCity
    }
}
