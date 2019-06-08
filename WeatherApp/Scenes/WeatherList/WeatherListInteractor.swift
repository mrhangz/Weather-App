//
//  WeatherListInteractor.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 7/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

import UIKit

protocol WeatherListInteractorInterface {
    func updateLocation(request: WeatherList.UpdateLocation.Request)
    func getWeatherData(request: WeatherList.GetWeatherData.Request)
    func selectWeatherData(request: WeatherList.SelectWeatherData.Request)
    var weatherData: [String: WeatherData] { get }
    var selectedCity: String! { get }
    var selectedWeatherData: WeatherData! { get }
}

class WeatherListInteractor: WeatherListInteractorInterface {
    var presenter: WeatherListPresenterInterface!
    var worker: WeatherListWorker?
    var weatherData: [String: WeatherData] = [:]
    var selectedCity: String!
    var selectedWeatherData: WeatherData!
    
    // MARK: - Business logic
    
    func selectWeatherData(request: WeatherList.SelectWeatherData.Request) {
        selectedWeatherData = weatherData[request.city]
        selectedCity = request.city
        presenter.presentSelectedWeatherData(request: WeatherList.SelectWeatherData.Response())
    }
    
    func updateLocation(request: WeatherList.UpdateLocation.Request) {
        let params = ["lat": request.lat, "lon": request.lon]
        getData(params: params)
    }
    
    func getWeatherData(request: WeatherList.GetWeatherData.Request) {
        worker?.getCities() { [weak self] result in
            for city in result {
                self?.getData(params: ["q": city])
            }
        }
    }
    
    private func getData(params: [String: Any]) {
        worker?.getWeatherData(parameters: params) { [weak self] result in
            let city = params["q"] as? String ?? "Current Location"
            if case let .success(data) = result {
                self?.weatherData[city] = data
            }
            let response = WeatherList.GetWeatherData.Response(city: city, result: result)
            self?.presenter.presentWeatherData(response: response)
        }
    }
}
