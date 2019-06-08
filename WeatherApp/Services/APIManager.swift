//
//  APIManager.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 7/6/19.
//  Copyright © 2019 mrhangz. All rights reserved.
//

import Foundation
import Alamofire

protocol APIManagerProtocol {
    func getWeather(params: [String: Any], completion: @escaping (Swift.Result<WeatherData, Error>) -> Void)
}

class APIManager: APIManagerProtocol {
    let baseURL: String = "https://api.openweathermap.org/data/2.5/weather"
    let appID: String = "fead546acf129c1d19fa6665c01bd424"
    static let shared: APIManager = APIManager()
    
    func getWeather(params: [String: Any], completion: @escaping (Swift.Result<WeatherData, Error>) -> Void) {
        Alamofire.request("\(baseURL)?appid=\(appID)", parameters: params)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let weatherData = try JSONDecoder().decode(WeatherData.self, from: response.data!)
                        completion(.success(weatherData))
                    } catch (let error) {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
