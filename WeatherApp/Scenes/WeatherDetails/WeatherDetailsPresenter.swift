//
//  WeatherDetailsPresenter.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 9/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

import UIKit

protocol WeatherDetailsPresenterInterface {
    func presentWeatherData(response: WeatherDetails.GetWeatherData.Response)
}

class WeatherDetailsPresenter: WeatherDetailsPresenterInterface {
    weak var viewController: WeatherDetailsViewControllerInterface!
    
    // MARK: - Presentation logic
    
    func presentWeatherData(response: WeatherDetails.GetWeatherData.Response) {
        let minTemp = "\(response.weatherData.main.minTemp)°F"
        let maxTemp = "\(response.weatherData.main.maxTemp)°F"
        let cloud = "\(response.weatherData.clouds.all)%"
        let windSpeed = "\(response.weatherData.wind.speed) meter/sec"
        let windDirection = "\(response.weatherData.wind.deg) degrees"
        let viewModel = WeatherDetails.GetWeatherData.ViewModel(city: response.city,
                                                                minTemp: minTemp,
                                                                maxTemp: maxTemp,
                                                                windSpeed: windSpeed,
                                                                windDirection: windDirection,
                                                                cloud: cloud)
        viewController.displayWeatherData(viewModel: viewModel)
    }
}
