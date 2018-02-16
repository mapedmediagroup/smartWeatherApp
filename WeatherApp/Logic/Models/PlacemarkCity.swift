//
//  PlacemarkCity.swift
//  WeatherApp
//
//  Created by maksim_p on 11.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import Foundation

class PlacemarkCity {
    
    var city: String
    var country: String
    var lat : Double
    var lon : Double
    
    init(city: String, country: String, lat : Double, lon : Double) {
        self.city = city
        self.country = country
        self.lat = lat
        self.lon = lon
    }
    
}
