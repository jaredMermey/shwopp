//
//  LoginViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 5/7/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedFBLogin(sender: AnyObject) {
        PFFacebookUtils.logInWithPermissions(["public_profile", "user_about_me", "user_birthday", "email", "user_friends"], block: {
        user, error in
            if user == nil {
                println("uh oh the user cancelled the FB login")
                //add UI alert to tell user they need to approve it for FB
                return
            }
            else if user!.isNew{
                println("user signed up and logged in through FB")
                FBRequestConnection.startWithGraphPath("/me?fields=picture,first_name,birthday,gender,email,name", completionHandler: {
                    connection, result, error in
                    var r = result as! NSDictionary
                    user!["firstName"] = r["first_name"]
                    user!["fullName"] = r["name"]
                    user!["isVerified"] = false
                    user!["gender"] = r["gender"]
                    user!["email"] = r["email"]
                    
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    user!["birthday"] = dateFormatter.dateFromString(r["birthday"] as! String)
                    
                    let pictureURL = ((r["picture"] as! NSDictionary)["data"] as! NSDictionary)["url"] as! String
                    let url = NSURL(string: pictureURL)
                    let request = NSURLRequest(URL: url!)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
                        response, data, error in
                        
                        let imageFile = PFFile(name: "avatar.jpg", data: data)
                        user!["picture"] = imageFile
                        user!.saveInBackgroundWithBlock(nil)
                    })
                    }
                )
            }
            else {
                println("user logged in through FB")
            }
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardsNavController") as? UIViewController
            self.presentViewController(vc!, animated: true, completion: nil)
        })
    }
}
