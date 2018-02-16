//
//  Serializer.swift
//  WeatherApp
//
//  Created by maksim_p on 11.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import Foundation

class Serializer<T> {
    
    func parceData(data: Data, headers: Dictionary<String, AnyObject>? = nil) -> (responce: T?, error: Error?) {
        fatalError("Not implemented parceData")
    }
    
}

class EmptySerializer: Serializer<Bool> {
    
    override func parceData(data: Data, headers: Dictionary<String, AnyObject>? = nil) -> (responce: Bool?, error: Error?) {
        return (true, nil)
    }
}

class DataSerializer: Serializer<Data> {
    
    override func parceData(data: Data, headers: Dictionary<String, AnyObject>? = nil) -> (responce: Data?, error: Error?) {
        return (data, nil)
    }
}

