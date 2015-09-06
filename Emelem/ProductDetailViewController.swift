//
//  ProductDetailViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 7/2/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var productSku: String?
    var product: [Product] = []
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    
    
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var checkoutTableView: UITableView!
    
    var checkoutOptions = ["Size", "Color", "Ship to", "Pay with"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        fetchProductBySk(productSku!, {
            returnedProduct in
            self.product = returnedProduct
            
            self.product[0].getProductPhoto({
                    productImage in
                    self.productImage.image = productImage
                    self.productImage.contentMode = .ScaleAspectFill
                
                }
            )
            self.productDescription.text = self.product[0].productDescription
            self.productNameLabel.text = self.product[0].productName
            self.brandNameLabel.text = self.product[0].brandName
        })
        self.checkoutTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.checkoutOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CheckoutCell = tableView.dequeueReusableCellWithIdentifier("CheckoutCell", forIndexPath: indexPath) as! CheckoutCell
        cell.checkoutParamLabel.text = self.checkoutOptions[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "chatVCSegue" {
            let chatVC: ChatViewController = segue.destinationViewController as! ChatViewController
            chatVC.keptProductSKU = self.productSku
            chatVC.title = productNameLabel.text
        } else if segue.identifier == "mapVCSegue" {
            let mapVC: MapViewController = segue.destinationViewController as! MapViewController
            mapVC.keptProductSKU = self.productSku
            mapVC.title = productNameLabel.text
        }
    }
    
    @IBAction func buyButtonPressed(sender: AnyObject) {
        fetchProductBySk(productSku!, {
            returnedProduct in
            self.product = returnedProduct
            
            purchase(self.product[0])
            println("purchase completed")
        })
    }
    
    
}
