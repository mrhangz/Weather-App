//
//  WeatherListInteractorTests.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 9/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

@testable import WeatherApp
import XCTest

class WeatherListInteractorTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: WeatherListInteractor!
    var workerSpy: WeatherListWorkerSpy!
    var presenterSpy: WeatherListPresenterSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupWeatherListInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupWeatherListInteractor() {
        sut = WeatherListInteractor()
        workerSpy = WeatherListWorkerSpy(store: WeatherListStore())
        presenterSpy = WeatherListPresenterSpy()
        sut.presenter = presenterSpy
        sut.worker = workerSpy
    }
    
    // MARK: - Test doubles
    
    class WeatherListWorkerSpy: WeatherListWorker {
        var getCitiesIsCalled = false
        var getWeatherDataIsCalled = false
        
        override func getCities(_ completion: @escaping ([String]) -> Void) {
            getCitiesIsCalled = true
            completion(["Bangkok"])
        }
        
        override func getWeatherData(parameters: [String : Any], _ completion: @escaping (Result<WeatherData, Error>) -> Void) {
            getWeatherDataIsCalled = true
            completion(.success(Seeds.WeatherDataSeed.weatherData))
        }
    }
    
    class WeatherListPresenterSpy: WeatherListPresenterInterface {
        var presentWeatherDataIsCalled = false
        var presentSelectedWeatherDataIsCalled = false
        
        func presentWeatherData(response: WeatherList.GetWeatherData.Response) {
            presentWeatherDataIsCalled = true
        }
        
        func presentSelectedWeatherData(request: WeatherList.SelectWeatherData.Response) {
            presentSelectedWeatherDataIsCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testGetWeatherDataShouldCallWorkerAndPresenter() {
        // Given
        
        // When
        sut.getWeatherData(request: WeatherList.GetWeatherData.Request())
        
        // Then
        XCTAssert(workerSpy.getWeatherDataIsCalled)
        XCTAssert(presenterSpy.presentWeatherDataIsCalled)
    }
    
    func testUpdateLocationShouldCallWorkerAndPresenter() {
        // Given
        
        // When
        sut.updateLocation(request: WeatherList.UpdateLocation.Request(lat: 10.0, lon: 100.0))
        
        // Then
        XCTAssert(workerSpy.getWeatherDataIsCalled)
        XCTAssert(presenterSpy.presentWeatherDataIsCalled)
    }
    
    func testSelectWeatherDataShouldCallPresenter() {
        // Given
        sut.weatherData = ["Bangkok": Seeds.WeatherDataSeed.weatherData]
        
        // When
        sut.selectWeatherData(request: WeatherList.SelectWeatherData.Request(city: "Bangkok"))
        
        // Then
        XCTAssertEqual(sut.selectedCity, "Bangkok")
        XCTAssertEqual(sut.selectedWeatherData.id, Seeds.WeatherDataSeed.weatherData.id)
        XCTAssert(presenterSpy.presentSelectedWeatherDataIsCalled)
    }
}
