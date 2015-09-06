//
//  NetworkKept.swift
//  Emelem
//
//  Created by Jared Mermey on 6/5/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import Foundation

struct NetworkKeptProduct {
    let sku: String
    let product: Product
}



func fetchNetworkKeptProducts( callback: ([NetworkKeptProduct]) -> ()){
    PFQuery(className: "Relationship")
    .whereKey("doer", equalTo: PFUser.currentUser()!.objectId!)
    .whereKey("type", equalTo: "follow")
        .findObjectsInBackgroundWithBlock({
            objects, error in
            if let relationships = objects as? [PFObject]{
                var followerIDs: [String] = []
                for relationship in relationships {
                    let followerId: String = relationship.objectForKey("recipient") as! String
                    followerIDs.append(followerId)
                }
                
                /*let myRelationships = relationships.map({
                    (object: PFObject)->(relationshipID: String, followerID:String)
                    in
                    (object.objectId! as String, object.objectForKey("recipient") as! String)
                })*/
                //var followerIDs = myRelationships.map({$0.followerID})
                var currentUserID = currentUser()!.id as String
                followerIDs += [currentUserID]
    
    //first Query isolates products that have been kept from Action class into an array
    PFQuery(className: "Action")
        .whereKey("byUser", containedIn: followerIDs)
        .whereKey("type", equalTo: "kept")
        .findObjectsInBackgroundWithBlock({
            objects, error in
            if let networkkeptProducts = objects as? [PFObject] {
                let myNetworkKeptProducts = networkkeptProducts.map({
                    (object: PFObject)->(networkKeptID: String, productSKU:String)
                    in
                    (object.objectId! as String, object.objectForKey("productSku") as! String)
                })
                let productIDs = myNetworkKeptProducts.map({$0.productSKU})
                
                
                //second query gets all of the information about each product in the array from the Product class
                PFQuery(className: "Product")
                    .whereKey("sku", containedIn: productIDs)
                    .findObjectsInBackgroundWithBlock({
                        objects, error in
                        if let products = objects as? [PFObject] {
                            var products = reverse(products)
                            var m = Array<NetworkKeptProduct>()
                            for (index, product) in enumerate(products){
                                m.append(NetworkKeptProduct(sku: myNetworkKeptProducts[index].productSKU, product: productToProduct(product)))
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
})
    
}


