//
//  APIRequest.swift
//  WeatherApp
//
//  Created by maksim_p on 11.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestInterface {
    
    associatedtype ResponceType
    
    var params: [String : AnyObject]? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var scopes: [String]? { get }
    var headers: [String: String] { get }
    var anonymous: Bool { get }
    var encoding: ParameterEncoding { get }
    var serializer: Serializer<ResponceType> { get }
}


extension RequestInterface {
    
    var params: [String : AnyObject]? {
        return [:]
    }
    
    var path: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    var scopes: [String]? {
        return nil
    }
    
    var anonymous: Bool {
        return false
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding()
    }
    
    var serializer: Serializer<Bool> {
        return EmptySerializer()
    }
    
    
}
