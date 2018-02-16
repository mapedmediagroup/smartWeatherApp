//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by maksim_p on 11.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryCityLabel: UILabel!
    
    func configure(city: PlacemarkCity) {
        cityNameLabel.text = city.city
        countryCityLabel.text = city.country
    }
}
