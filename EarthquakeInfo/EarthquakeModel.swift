//
//  ListingModel.swift
//  EarthquakeInfo
//
//  Created by RUI WANG on 17/04/2017.
//  Copyright © 2017 Rui Wang. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 {
 “src”: “us”,
 “eqid”: “c000is61”,
 “timedate”: 2013-07-29 22:22:48”,
 “lat”: 7.6413,
 “lon”: 93.6871”,
 “magnitude”: 4.6,
 “depth”: 40.90,
 “region”: “Nicobar Islands, India region”
 }
 */
class EarthquakeModel: Mappable{
    
    var src: String = ""
    var eqid: String = ""
    var timedate: String = ""
    var lat: String = ""
    var lon: String = ""
    var magnitude: String = ""
    var depth: String = ""
    var region: String = ""
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        src <- map["src"]
        eqid <- map["eqid"]
        timedate <- map["timedate"]
        lat <- map["lat"]
        lon <- map["lon"]
        magnitude <- map["magnitude"]
        depth <- map["depth"]
        region <- map["region"]
    }
    
    func latitude() -> Double{
        return Double(lat) ?? 0.0
    }
    
    func longitude() -> Double{
        return Double(lon) ?? 0.0
    }
    
    
}
