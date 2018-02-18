//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by maksim_p on 11.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import UIKit

class WeatherCityTableViewCell: UITableViewCell{
    
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
        
    func configure(_ cityName: String? = nil, isDaily: Bool, detail: DayWeatherModel? = nil) {
        
        if isDaily {
            if let city = cityName {
                configufeIsDaily(city)
            }
        }else {
            if let detailInfo = detail {
                configureIsForecast(detailInfo)
            }
        }
    }
    
    func configufeIsDaily(_ cityName: String) {
        
        titleLabel.text = cityName
        APIProvider().getCityInfo(city: cityName) { (cityMain) in
            
            if let cityTemp: Double = cityMain.temp{
                self.temperatureLabel?.text = "\(String(format:"%.0f", cityTemp)) º"
            }
            if let cityIcon = cityMain.icon{
                self.tempImageView.image = UIImage(named: cityIcon)
            }else {
                self.tempImageView.image = UIImage(named: "none")
            }
        }
        
    }
    
    func configureIsForecast(_ detailWeather: DayWeatherModel) {
        
        if let dateString = DataTimeFormat.getDay(detailWeather.name) {
            self.titleLabel.text = dateString
        }
        self.temperatureLabel.text = "\(String(format:"%.0f", detailWeather.temperature)) º"
        self.tempImageView.image = UIImage(named: detailWeather.imageName)
    }
    
}
