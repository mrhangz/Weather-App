//
//  WeatherDetailsRouter.swift
//  WeatherApp
//
//  Created by Teerawat Vanasapdamrong on 9/6/19.
//  Copyright (c) 2019 mrhangz. All rights reserved.
//

import UIKit

protocol WeatherDetailsRouterInput {
}

class WeatherDetailsRouter: WeatherDetailsRouterInput {
  weak var viewController: WeatherDetailsViewController!

  // MARK: - Navigation

  // MARK: - Communication

  func passDataToNextScene(segue: UIStoryboardSegue) {
  }

  func passDataToSomewhereScene(segue: UIStoryboardSegue) {
  }
}
