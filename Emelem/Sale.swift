//
//  Sale.swift
//  Emelem
//
//  Created by Jared Mermey on 8/11/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import Foundation

struct Sale {
    let sku: String
    let price: Double
    let shippingCost: Double
    let purchaserId: String
}

struct CommissionedProduct {
    let sku: String
    let product: Product
}

func purchase(product: Product){
    
    var totalCost = product.price + product.shippingCost
    
    let sale = PFObject(className: "Sale")
    sale.setObject(PFUser.currentUser()!.objectId!, forKey: "purchaserId")
    sale.setObject(product.sku, forKey: "productSku")
    sale.setObject(product.price, forKey: "price")
    sale.setObject(product.shippingCost, forKey: "shippingPrice")
    sale.setObject(totalCost, forKey: "totalChare")
    sale.saveInBackgroundWithBlock(nil)
}

func fetchCommissions( callback: ([CommissionedProduct]) -> ()){
    PFQuery(className: "Relationship")
        .whereKey("doer", equalTo: PFUser.currentUser()!.objectId!)
        .whereKey("type", equalTo: "follow")
        .findObjectsInBackgroundWithBlock({
            objects, error in
            if let relationships = objects as? [PFObject]{
                let myRelationships = relationships.map({
                    (object: PFObject)->(relationshipID: String, followerID:String)
                    in
                    (object.objectId! as String, object.objectForKey("recipient") as! String)
                })
                var followerIDs = myRelationships.map({$0.followerID})

                
                //first Query isolates products that have been kept from Action class into an array
                PFQuery(className: "Sale")
                    .whereKey("purchaserId", containedIn: followerIDs)
                    .findObjectsInBackgroundWithBlock({
                        objects, error in
                        if let commissionedSales = objects as? [PFObject] {
                            let myCommissionedSales = commissionedSales.map({
                                (object: PFObject)->(saleID: String, productSKU:String)
                                in
                                (object.objectId! as String, object.objectForKey("productSku") as! String)
                            })
                            let saleIDs = myCommissionedSales.map({$0.productSKU})
                            println(saleIDs)
                            
                            //second query gets all of the information about each product in the array from the Product class
                            PFQuery(className: "Product")
                                .whereKey("sku", containedIn: saleIDs)
                                .findObjectsInBackgroundWithBlock({
                                    objects, error in
                                    if let products = objects as? [PFObject] {
                                        var products = reverse(products)
                                        var m = Array<CommissionedProduct>()
                                        for (index, product) in enumerate(products){
                                            m.append(CommissionedProduct(sku: myCommissionedSales[index].productSKU, product: productToProduct(product)))
                                        }
                                        println(m)
                                        for i in m {
                                            let sku = i.sku
                                            println(sku)
                                        }
                                        callback(m)
                                    }
                                })
                        }
                    })
            }
        })
    
}


