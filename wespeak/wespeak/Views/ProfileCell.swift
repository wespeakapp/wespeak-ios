//
//  ProfileCell.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/27/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.make(cornerRadius: profileImage.frame.height/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
