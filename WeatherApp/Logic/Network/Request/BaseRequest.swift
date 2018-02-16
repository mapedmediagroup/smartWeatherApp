//
//  BaseRequest.swift
//  WeatherApp
//
//  Created by maksim_p on 11.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import Foundation

protocol BaseRequest {
    var appidDic: [String : String] { get }
}

extension RequestInterface where Self: BaseRequest {
    
    var appidDic: [String : String] {
        return ["APPID" : APIConstants.APIKey]
    }
    
}
