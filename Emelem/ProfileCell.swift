//
//  ProfileCell.swift
//  Emelem
//
//  Created by Jared Mermey on 7/15/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var invitedCountLabel: UILabel!
    
    @IBOutlet weak var likeStaticLabel: UILabel!
    @IBOutlet weak var followersStaticLabel: UILabel!
    @IBOutlet weak var followingStaticLabel: UILabel!
    @IBOutlet weak var invitedStaticLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
