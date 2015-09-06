//
//  Kept.swift
//  Emelem
//
//  Created by Jared Mermey on 5/20/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import Foundation

struct KeptProduct {
    let sku: String
    let product: Product
}

func fetchKeptProducts( callback: ([KeptProduct]) -> ()){
    //first Query isolates products that have been kept from Action class into an array
    PFQuery(className: "Action")
    .whereKey("byUser", equalTo: PFUser.currentUser()!.objectId!)
    .whereKey("type", equalTo: "kept")
    .findObjectsInBackgroundWithBlock({
        objects, error in
        if let keptProducts = objects as? [PFObject] {
            let myKeptProducts = keptProducts.map({
                (object: PFObject)->(keptID: String, productSKU:String)
                    in
                (object.objectId! as String, object.objectForKey("productSku") as! String)
            })
            let productIDs = myKeptProducts.map({$0.productSKU})
            
            
            //second query gets all of the information about each product in the array from the Product class
            PFQuery(className: "Product")
            .whereKey("sku", containedIn: productIDs)
            .findObjectsInBackgroundWithBlock({
                objects, error in
                if let products = objects as? [PFObject] {
                    var products = reverse(products)
                    var m = Array<KeptProduct>()
                    for (index, product) in enumerate(products){
                        m.append(KeptProduct(sku: myKeptProducts[index].productSKU, product: productToProduct(product)))
                    }
                    
                    for i in m {
                        let sku = i.sku
                        
                    }
                    callback(m)
                }
            })
        }
    })
}

