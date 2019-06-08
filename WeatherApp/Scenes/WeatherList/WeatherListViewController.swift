//
//  WeatherListViewController.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 7/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherListViewControllerInterface: class {
    func displayCurrentLocationWeatherData(viewModel: WeatherList.GetWeatherData.ViewModel)
    func displayWeatherData(viewModel: WeatherList.GetWeatherData.ViewModel)
    func displaySelectedWeatherData(viewModel: WeatherList.SelectWeatherData.ViewModel)
}

class WeatherListViewController: UITableViewController, WeatherListViewControllerInterface {
    var interactor: WeatherListInteractorInterface!
    var router: WeatherListRouter!
    
    var displayedWeatherDatas: [WeatherList.GetWeatherData.ViewModel] = []
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure(viewController: self)
    }
    
    // MARK: - Configuration
    
    func configure(viewController: WeatherListViewController) {
        let router = WeatherListRouter()
        router.viewController = viewController
        
        let presenter = WeatherListPresenter()
        presenter.viewController = viewController
        
        let interactor = WeatherListInteractor()
        interactor.presenter = presenter
        interactor.worker = WeatherListWorker(store: WeatherListStore())
        
        viewController.interactor = interactor
        viewController.router = router
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData()
        getLocation()
    }
    
    // MARK: - Event handling
    
    func getLocation() {
        LocationManager.shared.delegate = self
        LocationManager.shared.getLocation()
    }
    
    func getLocationWeatherData() {
        
    }
    
    func getWeatherData() {
        let request = WeatherList.GetWeatherData.Request()
        interactor.getWeatherData(request: request)
    }
    
    // MARK: - Display logic
    
    func displayCurrentLocationWeatherData(viewModel: WeatherList.GetWeatherData.ViewModel) {
        displayedWeatherDatas.insert(viewModel, at: 0)
        tableView.reloadData()
    }
    
    func displayWeatherData(viewModel: WeatherList.GetWeatherData.ViewModel) {
        displayedWeatherDatas.append(viewModel)
        tableView.reloadData()
    }
    
    func displaySelectedWeatherData(viewModel: WeatherList.SelectWeatherData.ViewModel) {
        router.navigateToWeatherDetails()
    }
    
    // MARK: - Router
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
    
    @IBAction func unwindToWeatherListViewController(from segue: UIStoryboardSegue) {
        print("unwind...")
        router.passDataToNextScene(segue: segue)
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.displayData(viewModel: displayedWeatherDatas[indexPath.row].displayedCell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedWeatherDatas.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayedCell = displayedWeatherDatas[indexPath.row].displayedCell
        interactor.selectWeatherData(request: WeatherList.SelectWeatherData.Request(city: displayedCell.city))
    }
}

extension WeatherListViewController: LocationManagerDelegate {
    func locationDidUpdate(location: CLLocation) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        interactor.updateLocation(request: WeatherList.UpdateLocation.Request(lat: lat, lon: lon))
    }
}
