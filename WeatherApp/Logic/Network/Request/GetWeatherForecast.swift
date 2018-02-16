//
//  GetWeatherForcast.swift
//  WeatherApp
//
//  Created by maksim_p on 12.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import Foundation

class GetWeatherForecast: RequestInterface, BaseRequest {
    
    var citySearchString: String
    
    var path: String {
        return "forecast"
    }
    
    var params: [String : AnyObject]? {
        var fullParams: [String : AnyObject] = appidDic as [String : AnyObject]
        fullParams["q"] = citySearchString as AnyObject?
        fullParams["units"] = "metric" as AnyObject?
        return fullParams
    }
    
    var serializer: Serializer<ForcastJson> {
        return JSONSerializer<ForcastJson>.valueSerializer()
    }
    
    init(citySearchString: String ) {
        self.citySearchString = citySearchString
    }
    
}
