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
    @IBOutlet weak var nameLabel: UILabel!
    var user:User? {
        didSet {
            guard let user = user else {return}
            if let url = URL(string: user.profilePicture) {
                 profileImage.af_setImage(withURL: url)
            }
            nameLabel.text = user.name
        }
    }
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
