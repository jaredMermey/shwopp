//
//  User.swift
//  Emelem
//
//  Created by Jared Mermey on 5/8/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import Foundation

struct User {
    let id: String
    let name: String
    let fullName: String
    private let pfUser: PFUser
    
    func getPhoto( callback:(UIImage) -> () ){
        let imageFile = pfUser.objectForKey("picture") as! PFFile
        imageFile.getDataInBackgroundWithBlock({
            data, error in
            if let data = data {
                callback(UIImage(data:data)!)
            }
        })
    }
    
}

private func pfUsertoUser (user: PFUser) -> User {
    return User(id: user.objectId!, name: user.objectForKey("firstName") as! String, fullName: user.objectForKey("fullName") as! String,pfUser: user)
}

func currentUser() -> User? {
    if let user = PFUser.currentUser() {
        return pfUsertoUser(user)
    }
    return nil
}

//Get users for referals
//find people who liked product
func fetchReferredbySku(sku: String, callback: ([User]) -> ()){
   var query =  PFQuery(className: "Action")
        query.whereKey("productSku", equalTo: sku)
        query.whereKey("type", equalTo: "kept")
        var data: Void? = query.findObjectsInBackgroundWithBlock({
            objects, error in
            if let likedProducts = objects as? [PFObject] {
                let myLikedProducts = likedProducts.map({
                    (object: PFObject)->(likedProductID: String, referrer:String)
                    in
                    (object.objectId! as String, object.objectForKey("byUser") as! String)
                })
                let referrerIDs = myLikedProducts.map({$0.referrer})
                
            //find which of people who liked product I follow
            PFQuery(className: "Relationship")
                .whereKey("type", equalTo: "follow")
                .whereKey("doer", equalTo: PFUser.currentUser()!.objectId!)
                .whereKey("recipient", containedIn: referrerIDs)
                .findObjectsInBackgroundWithBlock({
                    objects, error in
                    var friendIDs: [String] = []
                    
                    if let relationships = objects as? [PFObject] {
                        for relationship in relationships {
                            let friendId: String = relationship.objectForKey("recipient") as! String
                            friendIDs.append(friendId)
                        }
                        /*println(objects)
                        let myRelationships = relationships.map({
                            (object: PFObject)->(likedProductID: String, friend: String)
                            in
                            (object.objectId! as String, object.objectForKey("recipient") as! String)
                        })*/
                        //let friendIDs = myRelationships.map({$0.friend})
                //cllabck the people
                PFUser.query()!
                    .whereKey("objectId", containedIn: friendIDs)
                    .findObjectsInBackgroundWithBlock({
                        objects, error in
                        if let people = objects as? [PFUser] {
                            var people = reverse(people)
                            var m = Array<User>()
                            for i in people{
                                
                                let objectId = i.objectId!
                                let firstName: String = i.objectForKey("firstName") as! String
                                let fullName: String = i.objectForKey("fullName") as! String
                                m.append(User(id: objectId, name: firstName, fullName: fullName, pfUser: i))
                                //m.append(NetworkKeptProduct(sku: myNetworkKeptProducts[index].productSKU, product: productToProduct(product)))
                                }
                            
                            for i in m {
                                let name = i.name
                            }
                            callback(m)
                            }
                        })
                    }
                })
            }
    })
}

//TEST FOR CHAT

func getUserAsync(userID: String, callback: (User) -> () ) {
    PFUser.query()?.whereKey("objectId", equalTo: userID).getFirstObjectInBackgroundWithBlock( { (object, error) -> Void in
        if let pfUser = object as? PFUser {
            let user = pfUsertoUser(pfUser)
            callback(user) }
    })
}

// END TEST

//Function to get informtion need for suggested people to follow

func fetchSuggestedUsersToFollowByUser(userID: String, callback: ([String:Int]) -> ()){
    //get people currentUser follows
    println("this function was fired")
    PFQuery(className: "Relationship")
    .whereKey("doer", equalTo: "userID")
    .whereKey("type", equalTo: "follow")
    .findObjectsInBackgroundWithBlock({
        objects, error in
        if let relationships = objects as? [PFObject]{
            let myRelationships = relationships.map({
                (object: PFObject)->(relationshipID: String, followerID:String)
                in
                (object.objectId! as String, object.objectForKey("recipient") as! String)
            })
        var relationshipIds = myRelationships.map({$0.followerID})
            //get products liked by current users
            PFQuery(className: "Action")
            .whereKey("byUser", equalTo: PFUser.currentUser()!.objectId!)
            .whereKey("type", equalTo: "kept")
            .findObjectsInBackgroundWithBlock({
                objects, error in
                if let likes = objects as? [PFObject]{
                    let myLikes = likes.map({
                        (object: PFObject)->(likeID: String, sku:String)
                        in
                        (object.objectId! as String, object.objectForKey("productSku") as! String)
                })
                var likedSkus = myLikes.map({$0.sku})
                //find people current user does NOT follow who likes similar products
                    PFQuery(className: "Action")
                    .whereKey("byUser", notContainedIn: relationshipIds)
                    .whereKey("productSku", containedIn: likedSkus)
                    .findObjectsInBackgroundWithBlock({
                        objects, error in
                        if let suggestedFollowLikes = objects as? [PFObject]{
                            let thoseSuggestedFollowLikes = suggestedFollowLikes.map({
                                (object: PFObject)->(likeID: String, userID:String)
                                in
                                (object.objectId! as String, object.objectForKey("byUser") as! String)
                            })
                        var peopleToFollowIds = thoseSuggestedFollowLikes.map({$0.userID})
                        //create Dictionary of unique Ids in peopleToFollowIds and count for each
                            var counts:[String:Int] = [:]
                            for item in peopleToFollowIds {
                                counts[item] = (counts[item] ?? 0) + 1
                            }
                            //sort counts most to few
                            
                            var sortedCounts: [String: Int] = [:]
                            for (k,v) in (Array(counts).sorted {$0.1 < $1.1}) {
                                sortedCounts = ["\(k)":v]
                            }
                            
                            callback(sortedCounts)
                        }
                    })
                }
            })
        }
    })
}
//
var numberOfFollowers: Int = 0
var numberOfFollowing: Int = 0
var numberOfLikedItems: Int = 0

func getNumberOfFollowersForUser() -> Int {
    PFQuery(className: "Relationship")
        .whereKey("recipient", equalTo: PFUser.currentUser()!.objectId!)
        .whereKey("type", equalTo: "follow")
        .findObjectsInBackgroundWithBlock({
            objects, error
            in
            if let relationships = objects as? [PFObject]{
                numberOfFollowers = relationships.count
            }
        })
    return numberOfFollowers
}

func getNumberOfFollowingForUser() -> Int {
    PFQuery(className: "Relationship")
        .whereKey("doer", equalTo: PFUser.currentUser()!.objectId!)
        .whereKey("type", equalTo: "follow")
        .findObjectsInBackgroundWithBlock({
            objects, error
            in
            if let relationships = objects as? [PFObject]{
                numberOfFollowing = relationships.count
            }
        })
    return numberOfFollowing
}

func getNumberLikedItemsForUser() -> Int {
    PFQuery(className: "Action")
        .whereKey("byUser", equalTo: PFUser.currentUser()!.objectId!)
        .whereKey("type", equalTo: "kept")
        .findObjectsInBackgroundWithBlock({
            objects, error
            in
            if let relationships = objects as? [PFObject]{
                numberOfLikedItems = relationships.count
            }
        })
    return numberOfLikedItems
}



