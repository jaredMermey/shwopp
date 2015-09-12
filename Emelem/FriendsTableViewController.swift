//
//  FriendsTableViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 9/7/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class FriendsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //for all three
    @IBOutlet weak var friendSearchNav: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var personToFollow: User?
  
    //suggested person result array
    var suggestedPeopleToFollow: [String:Int] = [:]

    //search return
    var searchedPeopleToFollow:[String] = []
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    //var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    
    }
    
    override func viewWillAppear(animated: Bool) {
        if friendSearchNav.selectedSegmentIndex == 0 {
            fetchSuggestedUsersToFollowByUser(currentUser()!.id, {
                returnedDictionary in
                self.suggestedPeopleToFollow = returnedDictionary
                self.tableView.reloadData()
                println(self.suggestedPeopleToFollow)
            })
        }
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if friendSearchNav.selectedSegmentIndex == 0 {
            return suggestedPeopleToFollow.count
        } else if friendSearchNav.selectedSegmentIndex == 1 {
            return self.searchedPeopleToFollow.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SuggestedFriendCell = tableView.dequeueReusableCellWithIdentifier("SuggestedFriendCell", forIndexPath: indexPath) as! SuggestedFriendCell
        
        if friendSearchNav.selectedSegmentIndex == 0 {
            let suggestedFollowUserIds = [String](suggestedPeopleToFollow.keys)
            let suggestedFollowUserId: String = suggestedFollowUserIds[indexPath.row]
            //populate name label and avatar for suggested user
            getUserAsync(suggestedFollowUserId, {
                returnedUser in
                self.personToFollow = returnedUser
                cell.suggestedFollowNameLabel.text = self.personToFollow?.fullName
                
                self.personToFollow?.getPhoto({
                    avatarImage in
                    cell.suggestedFollowAvatar.image = avatarImage
                })
            })
            //grab suggested user overlap like count and populate comment label
            let suggestedFollowUserCommonLikeCountArray = [Int](suggestedPeopleToFollow.values)
            let suggestedFollowUserCommonLikeCount: Int = suggestedFollowUserCommonLikeCountArray[indexPath.row]
            cell.suggestFollowCommentLabel.text = "\(suggestedFollowUserCommonLikeCount) common liked items"
            
            return cell
        } else if friendSearchNav.selectedSegmentIndex == 1 {
            let searchedFriendId = searchedPeopleToFollow[indexPath.row]
            getUserAsync(searchedFriendId, {
                returnedUser in
                self.personToFollow = returnedUser
                cell.suggestedFollowNameLabel.text = self.personToFollow?.fullName
                
                self.personToFollow?.getPhoto({
                    avatarImage in
                    cell.suggestedFollowAvatar.image = avatarImage
                })
            })
            //ADD SOMETHING FOR THE COMMENT AREA -- # OF THINGS THEY LIKE AND/OR # OF PEOPLE WHO FOLLOW THEM
            return cell
            
        }
        return cell
    }
    
    // Mark - UISearchResultsUpdating
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        mySearchBar.resignFirstResponder()
        
        //might want to create function in user area that does all the below
        var firstNameQuery = PFUser.query()!
        .whereKey("firstName", matchesRegex: "(?i)\(searchBar.text)")
        
        var lastNameQuery = PFUser.query()!
        .whereKey("fullName", matchesRegex: "(?i)\(searchBar.text)")
           // .whereKey("fullName", containsString: "(?i)\(searchBar.text)")
        
        // a regular expression that will match the search word and the value in the Parse class
        // and the comparison will be case insensetive.
        
        var query = PFQuery.orQueryWithSubqueries([firstNameQuery, lastNameQuery])
        query.findObjectsInBackgroundWithBlock({
        objects, error in
            println(objects)
            //if search returns an error
            if error != nil {
                var myAlert = UIAlertController(title:"Alert", message:error?.localizedDescription, preferredStyle:UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil)
                return
            }
            if let results = objects as? [PFUser] {
                self.searchedPeopleToFollow.removeAll(keepCapacity: false)
                for result in results {
                    let personToFollowID = result.objectId! as String
                    self.searchedPeopleToFollow.append(personToFollowID)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                    self.mySearchBar.resignFirstResponder()
                    
                }
            }
        })

        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        mySearchBar.resignFirstResponder()
        mySearchBar.text = ""
    }
    
    //Mark -- Segmented Control Changing
    @IBAction func toggleNavPressed(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            
            self.tableView.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            
            self.tableView.reloadData()
        } else {
            
            self.tableView.reloadData()
        }
    }
}
