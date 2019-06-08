//
//  WeatherListModels.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 7/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

import UIKit

struct WeatherList {
    struct SelectWeatherData {
        struct Request {
            let city: String
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    struct UpdateLocation {
        struct Request {
            let lat: Double
            let lon: Double
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    struct GetWeatherData {
        struct Request {
        }
        struct Response {
            let city: String
            let result: Result<WeatherData, Error>
        }
        struct ViewModel {
            struct DisplayedCell {
                let city: String
                let iconURL: String
                let temperature: String
            }
            let displayedCell: DisplayedCell
        }
    }
}
