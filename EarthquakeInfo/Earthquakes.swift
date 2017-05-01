//
//  Earthquakes.swift
//  EarthquakeInfo
//
//  Created by RUI WANG on 17/04/2017.
//  Copyright © 2017 Rui Wang. All rights reserved.
//

import Foundation
import ObjectMapper

class Earthquakes: Mappable{
    var count: String = "0"
    var earthquakes: [EarthquakeModel] = [EarthquakeModel]()
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        earthquakes <- map["earthquakes"]
    }
    
}
