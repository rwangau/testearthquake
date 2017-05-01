//
//  ListingEventHandler.swift
//  EarthquakeInfo
//
//  Created by RUI WANG on 17/04/2017.
//  Copyright © 2017 Rui Wang. All rights reserved.
//

import Foundation

/**
    Description: This is a helper class to handle the HTTP request.
    In our case, it will download the earthquake data from API.
 */
class ListingEventHandler{
    
    var earthquakes: Earthquakes = Earthquakes()
    let apiManager: APIManager = APIManager()
    let url = "http://www.seismi.org/api/eqs"
    
    func numberOfItems() -> Int{
        return earthquakes.earthquakes.count
    }
    
    func object(at indexPath: IndexPath) -> EarthquakeModel? {
        let index = indexPath.row
        if index < earthquakes.earthquakes.count{
            return earthquakes.earthquakes[index]
        }
        
        return nil
    }
    
    func loadData(completion: @escaping () -> ()){
        apiManager.sendRequest(url: self.url , responseMappingClass: Earthquakes.self) { (response) in
            if let response = response as? Earthquakes{
                self.earthquakes = response
            }
            
            completion()
        }
    }
    
}
