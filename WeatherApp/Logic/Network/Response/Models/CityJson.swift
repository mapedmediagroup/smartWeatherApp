//
//  CityJson.swift
//  WeatherApp
//
//  Created by maksim_p on 12.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import Foundation

class CityJson: JSONRepresentable {
    
    var name: String?
    var temp: Double?
    var icon: String?
    
    
    required init?(json: [String : AnyObject]) {
        
        if let cityName = json["name"] as? String {
            self.name = cityName
            
            if let main = json["main"] {
                self.temp = main["temp"] as? Double
            }
            
            let weather = json["weather"] as? [[String:AnyObject]]
            if let weatherImage = weather?.first {
                self.icon = weatherImage["icon"] as? String
            }
            
        } else {
            return nil
        }
    }
    
}
