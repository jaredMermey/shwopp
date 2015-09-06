//
//  Product.swift
//  Emelem
//
//  Created by Jared Mermey on 5/14/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import Foundation
import MapKit

struct Product {
    let productName: String
    let brandName: String
    let sku: String
    let price: Double
    let shippingCost: Double
    let productDescription: String
    private let product: PFObject
    
    func getProductPhoto(callback:(UIImage) -> () ){
        let imageFile = product.objectForKey("productImage") as! PFFile
        imageFile.getDataInBackgroundWithBlock({
            data, error in
            if let data = data {
                callback(UIImage(data:data)!)
            }
        })
    }
    
    func getBrandPhoto(callback:(UIImage) -> () ){
        let imageFile = product.objectForKey("brandImage") as! PFFile
        imageFile.getDataInBackgroundWithBlock({
            data, error in
            if let data = data {
                callback(UIImage(data:data)!)
            }
        })
    }
    
}

func productToProduct (product: PFObject) -> Product {
    return Product(productName: product.objectForKey("productName") as! String, brandName: product.objectForKey("brandName") as! String, sku: product.objectForKey("sku") as! String, price: product.objectForKey("price") as! Double, shippingCost: product.objectForKey("shippingCost") as! Double, productDescription: product.objectForKey("productLongDescription") as! String, product: product)
}


//need to test this to see if it works. NO IDEA.
func fetchUnviewedProducts( callback: ([Product]) -> ()) {
    var query = PFQuery(className: "Product")
    query.findObjectsInBackgroundWithBlock({
    objects, error in
        if let productsFromParse = objects as? [PFObject] {
            let products = map(productsFromParse, {productToProduct($0)})
            callback(products)
        }
    })
}

func fetchProductBySk(sku: String, callback: ([Product]) -> ()){
    PFQuery(className: "Product")
    .whereKey("sku", equalTo: sku)
    .findObjectsInBackgroundWithBlock({
        objects, error in
        if let productsFromParse = objects as? [PFObject] {
            let products = map(productsFromParse, {productToProduct($0)})
            callback(products)
        }
    })
}

var tracking = GPSTrackingManager()

func saveSkip(product: Product){
    tracking.startTracking()
    var latValue = tracking.locationManager.location.coordinate.longitude
    var lonValue = tracking.locationManager.location.coordinate.latitude
    let geoPoint = PFGeoPoint(latitude: latValue, longitude: lonValue)
    
    let skip = PFObject(className: "Action")
    skip.setObject(PFUser.currentUser()!.objectId!, forKey: "byUser")
    skip.setObject(product.sku, forKey: "productSku")
    skip.setObject("skipped", forKey: "type")
    skip.setObject(geoPoint, forKey: "swipeLocation")
    skip.saveInBackgroundWithBlock(nil)
}

func saveKept(product: Product){
    tracking.startTracking()
    var latValue = tracking.locationManager?.location.coordinate.longitude
    var lonValue = tracking.locationManager?.location.coordinate.latitude
    let geoPoint = PFGeoPoint(latitude: latValue!, longitude: lonValue!)

    
    let save = PFObject(className: "Action")
    save.setObject(PFUser.currentUser()!.objectId!, forKey: "byUser")
    save.setObject(product.sku, forKey: "productSku")
    save.setObject("kept", forKey: "type")
    save.setObject(geoPoint, forKey: "swipeLocation")
    save.saveInBackgroundWithBlock(nil)
}