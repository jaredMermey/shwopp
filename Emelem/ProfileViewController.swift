//
//  ProfileViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 9/10/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit
import MessageUI

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

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
    
    //stats for profile
    var numberOfFollowers: Int = 0
    var numberOfFollowing: Int = 0
    var numberOfLikedItems: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameLabel.text = currentUser()?.fullName
        currentUser()?.getPhoto({
            image in
            self.userAvatarImage.layer.masksToBounds = true
            self.userAvatarImage.contentMode = .ScaleAspectFill
            self.userAvatarImage.image = image
        })
        getNumberOfFollowingForUser()
        getNumberOfFollowersForUser()
        getNumberLikedItemsForUser()
        
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            println("edit credit card")
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else if indexPath.row == 1 {
            println("edit bank account")
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else if indexPath.row == 2 {
            //this button gets user to where s/he can add/edit addresses
            
            performSegueWithIdentifier("shippingVCTableSegue", sender: indexPath)
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else if indexPath.row == 3 {
            //this button gets user to email customer service
            let mailComposeViewController = configuredMailComposerViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
            
            
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else {
            println("fifth thing")
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

    // email for customer support code
    
    func configuredMailComposerViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["jmermey@gmail.com"])
        mailComposerVC.setSubject("Help!")
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send email. Please check settings and network connectivity then try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        switch result.value {
            case MFMailComposeResultCancelled.value:
                println("cancelled mail")
            case MFMailComposeResultSent.value:
                println("mail sent")
            default:
                break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // helper functions and variables to get stats
    
    func getNumberOfFollowersForUser() {
        PFQuery(className: "Relationship")
            .whereKey("recipient", equalTo: PFUser.currentUser()!.objectId!)
            .whereKey("type", equalTo: "follow")
            .findObjectsInBackgroundWithBlock({
                objects, error
                in
                if let relationships = objects as? [PFObject]{
                    self.numberOfFollowers = relationships.count
                    self.followerCountLabel.text = "\(self.numberOfFollowers)"
                }
            })
    }
    
    func getNumberOfFollowingForUser() {
        PFQuery(className: "Relationship")
            .whereKey("doer", equalTo: PFUser.currentUser()!.objectId!)
            .whereKey("type", equalTo: "follow")
            .findObjectsInBackgroundWithBlock({
                objects, error
                in
                if let relationships = objects as? [PFObject]{
                    self.numberOfFollowing = relationships.count
                    self.followingCountLabel.text = "\(self.numberOfFollowing)"
                }
            })
        
    }
    
    func getNumberLikedItemsForUser() {
        PFQuery(className: "Action")
            .whereKey("byUser", equalTo: PFUser.currentUser()!.objectId!)
            .whereKey("type", equalTo: "kept")
            .findObjectsInBackgroundWithBlock({
                objects, error
                in
                if let relationships = objects as? [PFObject]{
                    self.numberOfLikedItems = relationships.count
                    self.likeCountLabel.text = "\(self.numberOfLikedItems)"
                }
            })
    }
    
}
