//
//  CustomMapView.swift
//  EarthquakeInfo
//
//  Created by RUI WANG on 17/04/2017.
//  Copyright © 2017 RUI WANG. All rights reserved.
//


import MapKit

/**
    Description: MapView Delegate for showing map pin annotations with animated around circle
 */
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView,
        viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseIdentifier = "pin"
        
        var v = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if v == nil {
            v = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            v?.canShowCallout = true
        }
        else {
            v?.annotation = annotation
        }
            
        if let customPointAnnotation = annotation as? CustomPointAnnotation{
            
            let pinSize = customPointAnnotation.pinSize
            
            UIGraphicsBeginImageContext(CGSize(width: pinSize.width, height: pinSize.height));
            let color = UIColor.blue
            color.setFill()
            let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: pinSize.width, height: pinSize.height))
            path.fill()
            let image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            v?.image = image
            
        }
        
        return v
    }
    
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for annotationView: MKAnnotationView in views{
            var duration = (Double)(arc4random_uniform(10))
            if duration == 0.0{
                duration = 1.0
            }
            let delay = duration/10.0 + 1.0
            annotationView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                annotationView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
    
}

