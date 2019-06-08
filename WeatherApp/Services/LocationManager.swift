//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 8/6/19.
//  Copyright © 2019 mrhangz. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func locationDidUpdate(location: CLLocation)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared: LocationManager = LocationManager()
    var locationManager: CLLocationManager!
    var location: CLLocation?
    var delegate: LocationManagerDelegate?
    
    private override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 20
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocation() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if location == nil, let newLocation = locations.last {
            location = newLocation
            self.delegate?.locationDidUpdate(location: newLocation)
            locationManager.stopUpdatingLocation()
        }
    }
}
