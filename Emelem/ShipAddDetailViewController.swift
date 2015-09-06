//
//  ShipAddDetailViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 6/11/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class ShipAddDetailViewController: UIViewController {
    
    
    @IBOutlet weak var addressTitleTextField: UITextField!
    @IBOutlet weak var streetAddTextField: UITextField!
    @IBOutlet weak var aptTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!

    var addressId: String?
    var addresses: [Address] = []
    
    override func viewDidLoad() {

        super.viewDidLoad()
               // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.addressId = appDelegate.editAddressId!
        
        fetchAddressesbyId(self.addressId!, {
            returnedAddresses in
            self.addresses = returnedAddresses
            
            self.addressTitleTextField.text = self.addresses[0].addressTitle
            self.streetAddTextField.text = self.addresses[0].streetAddress
            self.aptTextField.text = self.addresses[0].apt
            self.cityTextField.text = self.addresses[0].city
            self.stateTextField.text = self.addresses[0].state
            self.zipTextField.text = self.addresses[0].zip
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        //call save address function
     
        
        var addressTitle = self.addressTitleTextField.text
        var streetAddress = self.streetAddTextField.text
        var aptNo = self.aptTextField.text
        var city = self.cityTextField.text
        var state = self.stateTextField.text
        var zip = self.zipTextField.text
        

        var addressID =  addresses[0].addressId as String
        streetAddTextField.text = addresses[0].streetAddress as String
        aptTextField.text = addresses[0].apt as String
        cityTextField.text = addresses[0].city as String
        stateTextField.text = addresses[0].state as String
        zipTextField.text = addresses[0].zip as String
        
        println(addresses[0].apt)
        //saveAddress(addresses[0])
        
    }
 
}
