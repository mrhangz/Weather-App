//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 9/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

import UIKit

protocol WeatherDetailsViewControllerInterface: class {
    func displayWeatherData(viewModel: WeatherDetails.GetWeatherData.ViewModel)
}

class WeatherDetailsViewController: UIViewController, WeatherDetailsViewControllerInterface {
    var interactor: WeatherDetailsInteractorInterface!
    var router: WeatherDetailsRouter!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure(viewController: self)
    }
    
    // MARK: - Configuration
    
    func configure(viewController: WeatherDetailsViewController) {
        let router = WeatherDetailsRouter()
        router.viewController = viewController
        
        let presenter = WeatherDetailsPresenter()
        presenter.viewController = viewController
        
        let interactor = WeatherDetailsInteractor()
        interactor.presenter = presenter
        
        viewController.interactor = interactor
        viewController.router = router
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData()
    }
    
    // MARK: - Event handling
    
    func getWeatherData() {
        let request = WeatherDetails.GetWeatherData.Request()
        interactor.getWeatherData(request: request)
    }
    
    // MARK: - Display logic
    
    func displayWeatherData(viewModel: WeatherDetails.GetWeatherData.ViewModel) {
        cityLabel.text = viewModel.city
        minTempLabel.text = viewModel.minTemp
        maxTempLabel.text = viewModel.maxTemp
        windSpeedLabel.text = viewModel.windSpeed
        windDirectionLabel.text = viewModel.windDirection
        cloudLabel.text = viewModel.cloud
    }
    
    // MARK: - Router
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
    
    @IBAction func unwindToWeatherDetailsViewController(from segue: UIStoryboardSegue) {
        print("unwind...")
        router.passDataToNextScene(segue: segue)
    }
}
