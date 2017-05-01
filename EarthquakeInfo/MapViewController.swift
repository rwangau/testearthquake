//
//  MapViewController.swift
//  EarthquakeInfo
//
//  Created by RUI WANG on 17/04/2017.
//  Copyright © 2017 Rui Wang. All rights reserved.
//

import UIKit
import MapKit

/**
   Description: Desplaying map with earthquake locations, selected earthquake event will be focused and centered in the map.
*/
class MapViewController: UIViewController {

    var mapView: MKMapView = {
        let mapView = MKMapView(frame: CGRect.zero)
        
        return mapView
    }()
    
    let regionRadius: CLLocationDistance = 1000000

    var eventHandler: ListingEventHandler = ListingEventHandler()
    
    var selectedEarthquakeModel: EarthquakeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(mapView)
        
        
        
        mapView.delegate = self
        
        if eventHandler.numberOfItems() == 0 {
            eventHandler.loadData(completion: { 
                self.addAnnotations()
            })
        } else {
            self.addAnnotations()
        }
        
        if let selectedEarthquakeModel = selectedEarthquakeModel{
            let initialLocation = CLLocation(latitude: selectedEarthquakeModel.latitude(), longitude: selectedEarthquakeModel.longitude())
            centerMapOnLocation(initialLocation)
            
            for annotation:CustomPointAnnotation in self.mapView.annotations as! [CustomPointAnnotation]{
                if annotation.title == selectedEarthquakeModel.region {
                    self.mapView.selectAnnotation(annotation, animated: true)
                    break;
                }
            }
        }

    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        mapView.frame = self.view.bounds
    }


    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addAnnotations() {
        for earthquakeModel in eventHandler.earthquakes.earthquakes{
            
            let pointAnnoation = CustomPointAnnotation()
            
            pointAnnoation.coordinate = CLLocationCoordinate2D(latitude: earthquakeModel.latitude(), longitude: earthquakeModel.longitude())
            pointAnnoation.title = earthquakeModel.region
            pointAnnoation.subtitle = earthquakeModel.timedate
            pointAnnoation.pinSize = CGSize(width: 26.0, height: 26.0)
            
            self.mapView.addAnnotation(pointAnnoation)
            
        }
    }
    

}
