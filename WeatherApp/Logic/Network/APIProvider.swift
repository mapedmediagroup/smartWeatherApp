//
//  APIProvider.swift
//  WeatherApp
//
//  Created by maksim_p on 16.02.2018.
//  Copyright © 2018 maksim_p. All rights reserved.
//

import Foundation
import Alamofire


class APIProvider {
    
    var detailsWeather : [DayWeatherModel] = []
    var manager = APIClient()
    
    func getCityInfo(city: String, completion: @escaping (CityJson) -> Void) {
        
        manager.executeRequest(request: GetWeatherForCity(cityString:city)) { (cityMain, error) in
            if let cityMain = cityMain {
                completion(cityMain)
            }
        }
    }
    
    func getForecastWeather(_ cityName: String, completion: @escaping () -> Void)  {
        manager.executeRequest(request: GetWeatherForecast(citySearchString:cityName)) { (cityMain, error) in
            if let cityMain = cityMain {
                self.detailsWeather = cityMain.detailsWeather
                completion()
            }
        }
    }
}
