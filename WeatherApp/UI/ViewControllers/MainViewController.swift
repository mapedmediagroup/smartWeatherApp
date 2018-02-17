//
//  MainViewController.swift
//  WeatherApp
//
//  Created by maksim_p on 16.02.2018.
//  Copyright © 2018 maksim_p. All rights reserved.
//

import UIKit
import CarbonKit


class MainViewController: UIViewController, CarbonTabSwipeNavigationDelegate {
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        
        guard let storyboard = storyboard else { return UIViewController() }
        if InternetCheck.isConnectedToNetwork(){
            if index == 0 {
                return storyboard.instantiateViewController(withIdentifier: "CurrentLocationViewController")
            }
            return storyboard.instantiateViewController(withIdentifier: "CitiesViewController")
        }else {
            showMessage("No Internet")
            return storyboard.instantiateViewController(withIdentifier: "CitiesViewController")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabSwipe = CarbonTabSwipeNavigation(items: InternetCheck.isConnectedToNetwork() ? ["Current location", "Cities on devise"] : ["Cities on devise"], delegate: self)
        tabSwipe.setTabExtraWidth(40)
        tabSwipe.insert(intoRootViewController: self)
        
    }
}
