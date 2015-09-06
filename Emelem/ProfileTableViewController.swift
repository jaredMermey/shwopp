//
//  ProfileTableViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 7/15/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell1: ProfileCell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
            currentUser()?.getPhoto({
                image in
                cell1.profileImageView.layer.masksToBounds = true
                cell1.profileImageView.contentMode = .ScaleAspectFill
                cell1.profileImageView.image = image
            })
            return cell1
        } else if indexPath.section == 1 {
            let cell2: SettingCell = tableView.dequeueReusableCellWithIdentifier("SettingCell", forIndexPath: indexPath) as! SettingCell
            cell2.settingButton.setTitle("Commissions", forState: .Normal)
            cell2.contentView.backgroundColor = UIColor.redColor()
            /*cell2.settingButton.setImage(<#image: UIImage?#>, forState: .Normal) */
            return cell2
        } else if indexPath.section == 2 {
            let cell3: SettingCell = tableView.dequeueReusableCellWithIdentifier("SettingCell", forIndexPath: indexPath) as! SettingCell
            cell3.settingButton.setTitle("Credit Card", forState: .Normal)
            cell3.contentView.backgroundColor = UIColor.blueColor()
            /*cell3.settingButton.setImage(<#image: UIImage?#>, forState: .Normal) */
            return cell3
        } else if indexPath.section == 3 {
            let cell4: SettingCell = tableView.dequeueReusableCellWithIdentifier("SettingCell", forIndexPath: indexPath) as! SettingCell
            cell4.settingButton.setTitle("Address", forState: .Normal)
            cell4.contentView.backgroundColor = UIColor.greenColor()
            /*cell4.settingButton.setImage(<#image: UIImage?#>, forState: .Normal) */
            return cell4
        } else {
            let cell5: SettingCell = tableView.dequeueReusableCellWithIdentifier("SettingCell", forIndexPath: indexPath) as! SettingCell
            cell5.settingButton.setTitle("About Shwapp", forState: .Normal)
            cell5.contentView.backgroundColor = UIColor.yellowColor()
            /*cell5.settingButton.setImage(<#image: UIImage?#>, forState: .Normal) */
            return cell5
        }
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else {
            return 100
        }
    }
}
