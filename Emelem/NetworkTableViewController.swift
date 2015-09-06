//
//  NetworkTableViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 7/7/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class NetworkTableViewController: UITableViewController {
    
    var isFiltered = false
    
    var networkKeptProducts: [NetworkKeptProduct] = []
    var keptProducts: [KeptProduct] = []
    var referrers: [User] = []
    
    @IBOutlet weak var commissionTracker: UIBarButtonItem!
    var commissionTotal: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Your Network"
        
        if isFiltered == false {
            fetchNetworkKeptProducts({
                returnedNetworkKeptProducts in
                self.networkKeptProducts = returnedNetworkKeptProducts
                self.tableView.reloadData()
            })
        } else {
            fetchKeptProducts({
                returnedKeptProducts in
                self.keptProducts = returnedKeptProducts
                self.tableView.reloadData()
            })
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.commissionTotal = appDelegate.commissionTotal

        
        self.commissionTracker.title = "$\(self.commissionTotal!)"
        
        
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
        if isFiltered == false {
            return networkKeptProducts.count
        } else {
            return keptProducts.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
            let cell: ProductCell4 = tableView.dequeueReusableCellWithIdentifier("ProductCell4", forIndexPath: indexPath) as! ProductCell4
        
            if isFiltered == false {
                var product = networkKeptProducts[indexPath.row].product
                cell.productNameLabel.text = product.productName
                product.getProductPhoto({
                    productImage in
                    cell.productImageView.image = productImage
                })
                //cell.productPriceLabel.text = "$\(product.price)"
                let sku = product.sku
                fetchReferredbySku(sku, {
                    returnedReferrers in
                    self.referrers = returnedReferrers
                    
                    cell.referrerCountLabel.text = "\(self.referrers.count) friends like this"
                    //first referrer
                    if self.referrers.count >= 1 {
                        self.referrers[0].getPhoto({
                            userAvatar in
                            cell.referrerImageView.image = userAvatar
                            cell.referrerImageView.contentMode = .ScaleAspectFill
                        })
                    }
                    //second referrer
                    if self.referrers.count >= 2 {
                        self.referrers[1].getPhoto({
                            userAvatar2 in
                            cell.referrerImageView2.image = userAvatar2
                            cell.referrerImageView2.contentMode = .ScaleAspectFill
                        })
                    }
                    //third referrer
                    if self.referrers.count >= 3 {
                        self.referrers[2].getPhoto({
                            userAvatar in
                            cell.referrerImageView3.image = userAvatar
                            cell.referrerImageView3.contentMode = .ScaleAspectFill
                        })
                    }
                    //fourth referrer
                    if self.referrers.count >= 4 {
                        self.referrers[3].getPhoto({
                            userAvatar in
                            cell.referrerImageView4.image = userAvatar
                            cell.referrerImageView4.contentMode = .ScaleAspectFill
                        })
                    }
                    //fifth referrer
                    if self.referrers.count >= 5 {
                        self.referrers[4].getPhoto({
                            userAvatar in
                            cell.referrerImageView5.image = userAvatar
                            cell.referrerImageView5.contentMode = .ScaleAspectFill
                        })
                    }
                    //sixth referrer
                    if self.referrers.count >= 6 {
                        self.referrers[5].getPhoto({
                            userAvatar in
                            cell.referrerImageView6.image = userAvatar
                            cell.referrerImageView6.contentMode = .ScaleAspectFill
                        })
                    }
                    //seventh referrer
                    if self.referrers.count >= 7 {
                        self.referrers[6].getPhoto({
                            userAvatar in
                            cell.referrerImageView7.image = userAvatar
                            cell.referrerImageView7.contentMode = .ScaleAspectFill
                        })
                    }
                })
                
                cell.buyButton.setTitle("Buy - $\(product.price)", forState: .Normal)
                cell.brandNameLabel.text = product.brandName
                //cell.shipPriceLabel.text = "+ $\(product.shippingCost)S&H"
                cell.chatButton.tag = indexPath.row
                cell.mapButton.tag = indexPath.row
                return cell
            } else {
                var product = keptProducts[indexPath.row].product
                cell.productNameLabel.text = product.productName
                product.getProductPhoto({
                    productImage in
                    cell.productImageView.image = productImage
                })
                //cell.productPriceLabel.text = "$\(product.price)"
                cell.buyButton.setTitle("Buy - $\(product.price)", forState: .Normal)
                cell.brandNameLabel.text = product.brandName
                //cell.shipPriceLabel.text = "+ $\(product.shippingCost)S&H"
                cell.buyButton.tag = indexPath.row
                cell.chatButton.tag = indexPath.row
                cell.mapButton.tag = indexPath.row
                return cell
            }
    }


    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 450
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "chatVCSegue" {
            let chatVC: ChatViewController = segue.destinationViewController as! ChatViewController
            let networkKeptProduct = self.networkKeptProducts[sender!.tag]
            chatVC.keptProductSKU = networkKeptProduct.sku
            chatVC.title = networkKeptProduct.product.productName
        } else if segue.identifier == "mapVCSegue" {
            let mapVC: MapViewController = segue.destinationViewController as! MapViewController
            let networkKeptProduct = self.networkKeptProducts[sender!.tag]
            mapVC.keptProductSKU = networkKeptProduct.sku
            mapVC.title = networkKeptProduct.product.productName
        } else if segue.identifier == "detailsVCSegue" {
            let detailsVC: ProductDetailViewController = segue.destinationViewController as! ProductDetailViewController
            let networkKeptProduct = self.networkKeptProducts[sender!.tag]
            detailsVC.productSku = networkKeptProduct.sku
            detailsVC.title = networkKeptProduct.product.productName
        }
    }
    
    @IBAction func filterButtonPressed(sender: AnyObject) {
        if isFiltered == false {
            isFiltered = true
            
            fetchKeptProducts({
                returnedKeptProducts in
                self.keptProducts = returnedKeptProducts
                self.tableView.reloadData()
            })
            
            
            println(isFiltered)
        } else {
            isFiltered = false
            
            fetchNetworkKeptProducts({
                returnedNetworkKeptProducts in
                self.networkKeptProducts = returnedNetworkKeptProducts
                self.tableView.reloadData()
            })
            
            println(isFiltered)
        }
    }
    
    
    
}
