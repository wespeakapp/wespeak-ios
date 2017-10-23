//
//  CountryCell.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/14/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import FlagKit
class CountryCell: UITableViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    var country: Country? {
        didSet {
            let flag = Flag(countryCode: (country?.code)!)
            flagImageView.image = flag?.originalImage
            countryNameLabel.text = country?.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
