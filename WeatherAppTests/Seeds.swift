//
//  Seeds.swift
//  WeatherAppTests
//
//  Created by Teerawat Vanasapdamrong on 9/6/19.
//  Copyright © 2019 mrhangz. All rights reserved.
//

@testable import WeatherApp
import XCTest

struct Seeds {
    struct WeatherDataSeed {
        static let main = Main(temp: 100.0, humidity: 100, pressure: 100, minTemp: 10.0, maxTemp: 1000.0)
        static let wind = Wind(speed: 100.0, deg: 100.0)
        static let cloud = Cloud(all: 100)
        static let weather = Weather(id: 0, main: "main", description: "description", icon: "123")
        static let weatherData = WeatherData(id: 0,
                                             weather: [Seeds.WeatherDataSeed.weather],
                                             main: Seeds.WeatherDataSeed.main,
                                             wind: Seeds.WeatherDataSeed.wind,
                                             clouds: Seeds.WeatherDataSeed.cloud)
    }
}
