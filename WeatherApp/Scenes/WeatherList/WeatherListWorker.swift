//
//  WeatherListWorker.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 7/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

import Foundation

protocol WeatherListStoreProtocol {
    func getWeatherData(parameters: [String: Any], _ completion: @escaping (Result<WeatherData, Error>) -> Void)
    func getCities(_ completion: @escaping ([String]) -> Void)
}

class WeatherListWorker {
    
    var store: WeatherListStoreProtocol
    
    init(store: WeatherListStoreProtocol) {
        self.store = store
    }
    
    // MARK: - Business Logic
    
    func getWeatherData(parameters: [String: Any], _ completion: @escaping (Result<WeatherData, Error>) -> Void) {
        store.getWeatherData(parameters: parameters) { result in
            completion(result)
        }
    }
    
    func getCities(_ completion: @escaping ([String]) -> Void) {
        store.getCities() { result in
            completion(result)
        }
    }
}
