//
//  ProfileViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 9/10/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeStaticLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followerStaticLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followingStaticLabel: UILabel!
    @IBOutlet weak var summaryCommentLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameLabel.text = currentUser()?.fullName
        currentUser()?.getPhoto({
            image in
            self.userAvatarImage.layer.masksToBounds = true
            self.userAvatarImage.contentMode = .ScaleAspectFill
            self.userAvatarImage.image = image
        })
        
        likeCountLabel.text = "\(numberOfLikedItems)"
        followerCountLabel.text = "\(numberOfFollowers)"
        followingCountLabel.text = "\(numberOfFollowing)"
        summaryCommentLabel.text = "You've invited INSERT # INVITED friends and earned INSERT $ in commissions"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SettingCell = tableView.dequeueReusableCellWithIdentifier("SettingCell", forIndexPath: indexPath) as! SettingCell
        if indexPath.row == 0 {
            var imageView = UIImageView(frame: CGRectMake(10, 10, cell.frame.width - 10, cell.frame.height - 10))
            let image = UIImage(named: "nav-header")
            imageView.image = image
            cell.backgroundView = UIView()
            cell.backgroundView!.addSubview(imageView)
        } else if indexPath.row == 1 {
            var imageView = UIImageView(frame: CGRectMake(10, 10, cell.frame.width - 10, cell.frame.height - 10))
            let image = UIImage(named: "nav-header")
            imageView.image = image
            cell.backgroundView = UIView()
            cell.backgroundView!.addSubview(imageView)
        } else if indexPath.row == 2 {
            var imageView = UIImageView(frame: CGRectMake(10, 10, cell.frame.width - 10, cell.frame.height - 10))
            let image = UIImage(named: "nav-header")
            imageView.image = image
            cell.backgroundView = UIView()
            cell.backgroundView!.addSubview(imageView)
        } else if indexPath.row == 3 {
            var imageView = UIImageView(frame: CGRectMake(10, 10, cell.frame.width - 10, cell.frame.height - 10))
            let image = UIImage(named: "nav-header")
            imageView.image = image
            cell.backgroundView = UIView()
            cell.backgroundView!.addSubview(imageView)
        } else {
            var imageView = UIImageView(frame: CGRectMake(10, 10, cell.frame.width - 10, cell.frame.height - 10))
            let image = UIImage(named: "nav-header")
            imageView.image = image
            cell.backgroundView = UIView()
            cell.backgroundView!.addSubview(imageView)
        }
        return cell
    }
    
    // helper functions and variables to get stats
    
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
                    self.numberOfFollowers = relationships.count
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
                    self.numberOfFollowing = relationships.count
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
                    self.numberOfLikedItems = relationships.count
                }
            })
        return numberOfLikedItems
    }
    
}
