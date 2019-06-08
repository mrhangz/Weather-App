//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 8/6/19.
//  Copyright © 2019 mrhangz. All rights reserved.
//

import UIKit
import Kingfisher

class WeatherCell: UITableViewCell {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    func displayData(viewModel: WeatherList.GetWeatherData.ViewModel.DisplayedCell) {
        locationLabel.text = viewModel.city
        iconImageView.kf.setImage(with: URL(string: viewModel.iconURL))
        tempLabel.text = viewModel.temperature
    }
}
