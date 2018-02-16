//
//  APIClient.swift
//  WeatherApp
//
//  Created by maksim_p on 11.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import Foundation
import Alamofire

class APIClient{
    
    
    private var manager = SessionManager.default
    
    
    func executeRequest<T: RequestInterface, U>(request: T, completion: @escaping (U?, Error?) -> Void) where U == T.ResponceType {
        
        let url = APIConstants.BaseURL + "/" + request.path
        
        manager.request(url, method: request.method, parameters: request.params, encoding: request.encoding, headers: request.headers).responseData { dataResponce in
            if let data = dataResponce.data {
                print(data)
                let serializerResult = request.serializer.parceData(data: data)
                completion(serializerResult.responce, serializerResult.error)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func cancelAllRequests() -> Bool {
        
        return true
    }
    
}
