//
//  WeatherDetailsInteractor.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 9/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

import UIKit

protocol WeatherDetailsInteractorInterface {
    func getWeatherData(request: WeatherDetails.GetWeatherData.Request)
    var city: String! { get set }
    var weatherData: WeatherData! { get set }
}

class WeatherDetailsInteractor: WeatherDetailsInteractorInterface {
    var presenter: WeatherDetailsPresenterInterface!
    var city: String!
    var weatherData: WeatherData!
    
    // MARK: - Business logic
    
    func getWeatherData(request: WeatherDetails.GetWeatherData.Request) {
        let response = WeatherDetails.GetWeatherData.Response(city: city, weatherData: weatherData)
        presenter.presentWeatherData(response: response)
    }
}
