//
//  Location.swift
//  Emelem
//
//  Created by Jared Mermey on 5/18/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import Foundation
import MapKit

class GPSTrackingManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var seenError : Bool = false
    
    func startTracking() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50.0
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            if (seenError == false) {
                seenError = true
                print(error)
            }
        }
    }
    
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        //println("locations = \(locationManager)")
//        var latValue = locationManager.location.coordinate.latitude
//        var lonValue = locationManager.location.coordinate.longitude
//        
//        var geoPoint = [latValue, lonValue]
//        
//        println(latValue)
//        println(lonValue)
//        println(geoPoint)
    }
}