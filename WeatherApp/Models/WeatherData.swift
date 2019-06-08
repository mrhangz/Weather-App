//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 7/6/19.
//  Copyright © 2019 mrhangz. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let id: Int
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Cloud
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
    let pressure: Int
    let minTemp: Double
    let maxTemp: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case humidity
        case pressure
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}

struct Cloud: Decodable {
    let all: Int
}

struct Wind: Decodable {
    let speed: Double
    let deg: Double
}
