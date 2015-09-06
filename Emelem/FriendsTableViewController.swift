//
//  FriendsTableViewController.swift
//  Emelem
//
//  Created by Jared Mermey on 9/4/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    @IBOutlet weak var followFindMethodNav: UISegmentedControl!
    var suggestedPeopleToFollow: [String:Int] = [:]
    var personToFollow: User?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //what to load based on segment...testing fetchSuggestedUsersToFollow function
      
    }
   
   override func viewWillAppear(animated: Bool) {
      fetchSuggestedUsersToFollowByUser(currentUser()!.id, {
         returnedDictionary in
         self.suggestedPeopleToFollow = returnedDictionary
         self.tableView.reloadData()
         println(self.suggestedPeopleToFollow)
      })
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
        return suggestedPeopleToFollow.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell: SuggestedFriendCell = tableView.dequeueReusableCellWithIdentifier("SuggestedFriendCell", forIndexPath: indexPath) as! SuggestedFriendCell
      
      //grab userID for suggestUser
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
    }
   

}
