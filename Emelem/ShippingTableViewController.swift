//
//  ShippingTableViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 6/10/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class ShippingTableViewController: UITableViewController {

    //var shippingAddresses: [ShippingAddress] = []
    var addresses: [Address] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAddresses({
            returnedAddresses in
            self.addresses = returnedAddresses
            //println(self.addresses)
            self.tableView.reloadData()
            }
        )
        
        /*fetchUserAddresses({
            shippingAddresses in
            self.shippingAddresses = shippingAddresses
            self.tableView.reloadData()
        })*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return addresses.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShippingCell", forIndexPath: indexPath) as! ShippingCell
        //let address = shippingAddresses[indexPath.row]
        //let shippingAddress = addresses[indexPath.row]
        
        
        println(self.addresses[indexPath.row].addressId)
        cell.shippingAddTitleLabel.text = self.addresses[indexPath.row].addressTitle
        
        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //...write the code to go to the shipping address VC
        //look at how bitfountain does this in matches VC
        
            //let addDetailsVC = ShipAddDetailViewController()
                //navigationController?.pushViewController(addDetailsVC, animated: true)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.editAddressId = addresses[indexPath.row].addressId
            self.performSegueWithIdentifier("shipDetailVCSegue", sender: indexPath)
            //addDetailsVC.title = "Edit Your Address"
            //addDetailsVC.addressId = addresses[indexPath.row].addressId
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
}
