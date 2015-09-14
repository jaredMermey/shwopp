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
        let tableLength = addresses.count + 1
        return tableLength
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShippingCell", forIndexPath: indexPath) as! ShippingCell
        
        if indexPath.row <  self.addresses.count{
            cell.shippingAddTitleLabel.text = self.addresses[indexPath.row].addressTitle
        } else {
        cell.shippingAddTitleLabel.text = "Add another address"
        }
        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //...write the code to go to the shipping address VC
        //look at how bitfountain does this in matches VC
        self.performSegueWithIdentifier("shipDetailVCSegue", sender: self)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        var addDetailsVC: ShipAddDetailViewController = segue.destinationViewController as! ShipAddDetailViewController
        if (segue.identifier == "shipDetailVCSegue") {
            let indexPath = self.tableView.indexPathForSelectedRow()!
            if indexPath.row < self.addresses.count {
                var address: Address = self.addresses[indexPath.row]
                addDetailsVC.address = address
            }
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
}
