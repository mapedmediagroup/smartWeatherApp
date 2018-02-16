//
//  JSONSerializer.swift
//  WeatherApp
//
//  Created by maksim_p on 11.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import Foundation

protocol JSONRepresentable {
    
    init?(json: [String: AnyObject])
}

class JSONSerializer<T>: Serializer<T>{ //read generics
    
    typealias Transform = ((AnyObject, Dictionary<String, AnyObject>?) throws -> T?)
    
    let transform: Transform
    
    init(transform: @escaping Transform) {
        self.transform = transform
    }
    
    override func parceData(data: Data, headers: Dictionary<String, AnyObject>?) -> (responce: T?, error: Error?) {
        do {
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                let object = try transform(dictionary as AnyObject, headers)
                return (responce: object, error: nil)
            } else {
                return (responce: nil, error: nil)
            }
        } catch {
            return (responce: nil, error: error)
        }
    }
    
}

extension JSONSerializer where T: JSONRepresentable {
    
    //add throws
    
    class func valueSerializer(keyPath: String? = nil) -> JSONSerializer<T> {
        
        return JSONSerializer { jsonObject, _ in
            
            func map(_ object: [String: AnyObject])throws -> T? {
                if let directObject =  T(json: object)  {
                    return directObject
                } else {
                    return nil
                }
            }
            
            switch (jsonObject, keyPath) {
            case (let object as [String: AnyObject], let keyPath?):
                if let directObject = (object[keyPath] as? [String: AnyObject]) {
                    return try map(directObject)
                } else {
                    return nil
                }
            case (let object as [String: AnyObject], _):
                return try map(object)
            default:
                return nil
            }
        }
    }
    
    class func sequenceSerializer(keyPath: String? = nil) -> JSONSerializer<[T]> {
        return JSONSerializer<[T]>(transform: { jsonObject, headers in
            func map(_ objects: [[String: AnyObject]]) throws -> [T]? {
                return objects.reduce([T](), { container, rawValue -> [T]? in
                    if let value = T(json: rawValue), let container = container {
                        return container + [value]
                    } else {
                        return nil
                    }
                })
            }
            
            switch (jsonObject, keyPath) {
            case (let object as [String: AnyObject], let keyPath?):
                if let objects = object[keyPath] as? [[String: AnyObject]] {
                    return try map(objects)
                } else {
                    return nil
                }
                
            case (let objects as [[String: AnyObject]], _):
                return try map(objects)
                
            default:
                return nil
            }
        })
    }
    
    
}
