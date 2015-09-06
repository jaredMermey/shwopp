//
//  MapViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 5/18/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var keptProductSKU: String?
   
    var keptLocations: [PFGeoPoint] = []
    
    var keptLocationLatitude: CLLocationDegrees?
    var keptLocationLongitude: CLLocationDegrees?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayLocations() {
        
        PFQuery(className: "Action")
            .whereKey("productSku", equalTo: keptProductSKU!)
            .whereKey("type", equalTo: "kept")
            .findObjectsInBackgroundWithBlock({
                objects, error in
                if let keptList = objects as? [PFObject] {
                    for keptItem in keptList {
                        let keptLocation = keptItem["swipeLocation"] as! PFGeoPoint
                        self.keptLocations.append(keptLocation)
                    }
                    println(self.keptLocations.count)
                    if self.keptLocations.count > 0 {
                        for keptLocation in self.keptLocations {
                            self.keptLocationLatitude = keptLocation.latitude
                            self.keptLocationLongitude = keptLocation.longitude
                            
                            let location = CLLocationCoordinate2D(latitude: self.keptLocationLatitude!, longitude: self.keptLocationLongitude!)
                            let span = MKCoordinateSpanMake(1, 1)
                            let region = MKCoordinateRegionMake(location, span)
                            self.mapView.setRegion(region, animated: true)
                            
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = location
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                }
            })
    }
    

    
    

}
