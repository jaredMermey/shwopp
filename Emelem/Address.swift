//
//  Address.swift
//  Emelem
//
//  Created by Jared Mermey on 6/22/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import Foundation

struct Address {
    //figure out why id is breakng code. Not sure why I cannot retrieve it in pfAddressToAddress
    let addressId: String
    let addressTitle: String
    let streetAddress: String
    let apt: String
    let city: String
    let state: String
    let zip: String
    private let pfAddress: PFObject
}

private func pfAddressToAddress (address: PFObject) -> Address {
    return Address(addressId: address.objectId!, addressTitle: address.objectForKey("addressTitle") as! String, streetAddress: address.objectForKey("streetAddress") as! String, apt: address.objectForKey("apt") as! String, city: address.objectForKey("city") as! String, state: address.objectForKey("state") as! String, zip: address.objectForKey("zip") as! String, pfAddress: address)
}

func fetchAddresses(callback: ([Address]) -> ()) {
    PFQuery(className: "Address") 
    .whereKey("userId", equalTo: PFUser.currentUser()!.objectId!)
    .findObjectsInBackgroundWithBlock({
        objects, error in
        if let pfAddresses = objects as? [PFObject] {
            let addresses = map(pfAddresses, {pfAddressToAddress($0)})
            callback(addresses)
        }
    })
}


func fetchAddressesbyId(addressID: String, callback: ([Address]) -> ()) {
    PFQuery(className: "Address")
        .whereKey("userId", equalTo: PFUser.currentUser()!.objectId!)
        .findObjectsInBackgroundWithBlock({
            objects, error in
            if let pfAddresses = objects as? [PFObject] {
                let addresses = map(pfAddresses, {pfAddressToAddress($0)})
                callback(addresses)
            }
        })
}



func saveAddress(address: Address){
    
    

    
    PFQuery(className: "Address")
    .whereKey("objectId", equalTo: address.addressId)
        .getFirstObjectInBackgroundWithBlock({
        object, error in
            if object != nil {
                object!.setObject(PFUser.currentUser()!.objectId!, forKey: "userId")
                object!.setObject(address.addressTitle, forKey: "addressTitle")
                object!.setObject(address.streetAddress, forKey: "streetAddress")
                object!.setObject(address.apt, forKey: "apt")
                object!.setObject(address.city, forKey: "city")
                object!.setObject(address.state, forKey: "state")
                object!.setObject(address.zip, forKey: "zip")
                object!.saveInBackgroundWithBlock(nil)
            }
            else {
            let save = PFObject(className: "Address")
            
            save.setObject(PFUser.currentUser()!.objectId!, forKey: "userId")
            save.setObject(address.addressTitle, forKey: "addressTitle")
            save.setObject(address.streetAddress, forKey: "streetAddress")
            save.setObject(address.apt, forKey: "apt")
            save.setObject(address.city, forKey: "city")
            save.setObject(address.state, forKey: "state")
            save.setObject(address.zip, forKey: "zip")
            save.saveInBackgroundWithBlock(nil)
            }
        })
}