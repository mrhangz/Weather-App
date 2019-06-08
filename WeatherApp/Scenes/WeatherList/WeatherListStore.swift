//
//  WeatherListStore.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 7/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

import Foundation

class WeatherListStore: WeatherListStoreProtocol {
    func getWeatherData(parameters: [String: Any], _ completion: @escaping (Result<WeatherData, Error>) -> Void) {
        APIManager().getWeather(params: parameters) { result in
            completion(result)
        }
    }
    
    func getCities(_ completion: @escaping ([String]) -> Void) {
        // might implement something else like a database, and allow user to add cities
        completion(["London", "Tokyo"])
    }
}
