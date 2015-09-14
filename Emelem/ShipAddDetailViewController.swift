//
//  ShipAddDetailViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 6/11/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class ShipAddDetailViewController: UIViewController, IQDropDownTextFieldDelegate {
   
    
    @IBOutlet weak var addressTitleTextField: UITextField!
    @IBOutlet weak var streetAddTextField: UITextField!
    @IBOutlet weak var aptTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: IQDropDownTextField!
    @IBOutlet weak var zipTextField: UITextField!
    
    
    
    var address: Address?
    
    var states: [String] = ["", "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    
    override func viewDidLoad() {

        super.viewDidLoad()
               // Do any additional setup after loading the view.
        stateTextField.isOptionalDropDown = false
        stateTextField.itemList = self.states
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        
        if address != nil {
            addressTitleTextField.text = address?.addressTitle
            streetAddTextField.text = address?.streetAddress
            aptTextField.text = address?.apt
            cityTextField.text = address?.city
            stateTextField.text = address?.state
            zipTextField.text = address?.zip
        }
    }
    

    
    @IBAction func saveButtonPressed(sender: UIButton) {
        if address != nil {
            address?.addressTitle = self.addressTitleTextField.text
            address?.streetAddress = self.streetAddTextField.text
            address?.apt = self.aptTextField.text
            address?.city = self.cityTextField.text
            address?.state = self.stateTextField.text
            address?.zip = self.zipTextField.text
        } else {
            address = createAddress("", self.addressTitleTextField.text, self.streetAddTextField.text, self.aptTextField.text, self.cityTextField.text, self.stateTextField.text, self.zipTextField.text)
        }
        //println(address!.addressTitle)
        saveAddress(address!)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
}
    


 

