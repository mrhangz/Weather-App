//
//  WeatherListPresenter.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 7/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

import UIKit

protocol WeatherListPresenterInterface {
    func presentWeatherData(response: WeatherList.GetWeatherData.Response)
    func presentSelectedWeatherData(request: WeatherList.SelectWeatherData.Response)
}

class WeatherListPresenter: WeatherListPresenterInterface {
    weak var viewController: WeatherListViewControllerInterface!
    
    // MARK: - Presentation logic
    
    func presentSelectedWeatherData(request: WeatherList.SelectWeatherData.Response) {
        viewController.displaySelectedWeatherData(viewModel: WeatherList.SelectWeatherData.ViewModel())
    }
    
    func presentWeatherData(response: WeatherList.GetWeatherData.Response) {
        switch response.result {
        case .success(let data):
            let iconURL = "https://openweathermap.org/img/w/\(data.weather[0].icon).png"
            let temperature = "\(data.main.temp)°F"
            let displayedCell = WeatherList.GetWeatherData.ViewModel.DisplayedCell(city: response.city, iconURL: iconURL, temperature: temperature)
            let viewModel = WeatherList.GetWeatherData.ViewModel(displayedCell: displayedCell)
            if response.city == "Current Location" {
                viewController.displayCurrentLocationWeatherData(viewModel: viewModel)
            } else {
                viewController.displayWeatherData(viewModel: viewModel)
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
