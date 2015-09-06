//
//  CommissionCell.swift
//  Emelem
//
//  Created by Jared Mermey on 8/2/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class CommissionCell: UITableViewCell {
    
    @IBOutlet weak var earnedFromFriendAvatar: UIImageView!
    @IBOutlet weak var productBoughtImage: UIImageView!
    @IBOutlet weak var sentenceExplanationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
