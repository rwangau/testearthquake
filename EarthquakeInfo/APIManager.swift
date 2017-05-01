//
//  APIManager.swift
//  EarthquakeInfo
//
//  Created by RUI WANG on 17/04/2017.
//  Copyright © 2017 Rui Wang. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

/**
  Description: This networking class integrated with web API library for fetching data feed
*/

public typealias SendRequestSuccess = (_ response: AnyObject?) -> Void

class APIManager {
    
    func sendRequest<TObjectMapping : Mappable>( url: String,
                     responseMappingClass: TObjectMapping.Type,
                     success: @escaping SendRequestSuccess)
        
    {
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject(completionHandler: { (response: DataResponse<TObjectMapping>) in
            
            self.handleResponse(response: response, success: success)
            
        })
        
    }
    
    
    fileprivate func handleResponse<T>(response: DataResponse<T>, success: SendRequestSuccess)
    {
        
        var bodyString : String? = nil
        if let responseData = response.data{
            bodyString = String(data: responseData, encoding:String.Encoding.utf8)
        }
        
        print("response: %@", bodyString ?? "")
        
        if let resultValue = response.result.value
        {
            success(resultValue as AnyObject)
        } else {
            success(nil)
        }
        
        
    }
    
    
    
}
