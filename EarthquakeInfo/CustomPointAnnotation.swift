//
//  CustomPointAnnotation.swift
//  EarthquakeInfo
//
//  Created by RUI WANG on 17/04/2017.
//  Copyright © 2017 RUI WANG. All rights reserved.
//

import UIKit
import MapKit

/**
    Description: Customed point annotation for earthquake locations
 */
class CustomPointAnnotation: MKPointAnnotation {
    var numberOfBikes : Int = 0
    var locationName: String = ""
    var discipline: String = ""
    var pinSize:CGSize = CGSize(width: 20, height: 20)
    
    override init() {
        super.init()
    }
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        super.init()
        self.title = title
        self.subtitle = locationName
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
    }
}
