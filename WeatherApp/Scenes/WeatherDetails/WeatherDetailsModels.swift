//
//  WeatherDetailsModels.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 9/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

import UIKit

struct WeatherDetails {
    struct GetWeatherData {
        struct Request {
        }
        struct Response {
            let city: String
            let weatherData: WeatherData
        }
        struct ViewModel {
            let city: String
            let minTemp: String
            let maxTemp: String
            let windSpeed: String
            let windDirection: String
            let cloud: String
        }
    }
}
