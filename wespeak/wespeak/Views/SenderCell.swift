//
//  SenderCell.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/2/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class SenderCell: UITableViewCell {

    @IBOutlet weak var bubleView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        bubleView.make(cornerRadius: 6)
        // Configure the view for the selected state
    }

}
