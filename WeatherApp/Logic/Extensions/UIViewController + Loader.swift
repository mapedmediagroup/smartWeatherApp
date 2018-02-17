//
//  UIViewController + Loader.swift
//  WeatherApp
//
//  Created by maksim_p on 16.02.2018.
//  Copyright © 2018 maksim_p. All rights reserved.
//

import Foundation
import PKHUD

extension UIViewController {
    
    func showLoader() {
        HUD.show(.progress)
    }
    
    func hideLoader() {
        HUD.hide()
    }
    
    func showMessage(_ message: String) {
        HUD.flash(.label(message))
    }
    
    func checkInternet() {
        if !InternetCheck.isConnectedToNetwork() {
            showMessage("No Internet")
            
        }
    }
}
