//
//  GetWeatherForCity.swift
//  WeatherApp
//
//  Created by maksim_p on 12.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import Foundation

class GetWeatherForCity: RequestInterface, BaseRequest {
    
    var cityString: String
    
    var path: String {
        return "weather"
    }
    
    var params: [String : AnyObject]? {
        var fullParams: [String : AnyObject] = appidDic as [String : AnyObject]
        fullParams["q"] = cityString as AnyObject?
        fullParams["units"] = "metric" as AnyObject?
        return fullParams
    }
    
    var serializer: Serializer<CityJson> {
        return JSONSerializer<CityJson>.valueSerializer()
    }
    
    init(cityString: String ) {
        self.cityString = cityString
    }
    
}
