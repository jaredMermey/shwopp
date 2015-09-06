//
//  SuggestedFriendCell.swift
//  Emelem
//
//  Created by Jared Mermey on 9/5/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class SuggestedFriendCell: UITableViewCell {

    @IBOutlet weak var suggestedFollowAvatar: UIImageView!
    @IBOutlet weak var suggestedFollowNameLabel: UILabel!
    @IBOutlet weak var suggestFollowCommentLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
