//
//  MatchedPopup.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/25/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import FlagKit

protocol MatchedPopupDelegate: class {
    func start()
}

class MatchedPopup: UIView {

    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    weak var delegate: MatchedPopupDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: String(describing: MatchedPopup.self), bundle: Bundle(for: MatchedPopup.self))
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = self.bounds
        
        dialogView.make(cornerRadius: 6)
        dialogView.make(shadowRadius: 6)
        profilePicture.clipsToBounds = true
        profilePicture.make(cornerRadius: profilePicture.frame.height/2)
        let flag = Flag(countryCode: "US")
        flagImageView.image = flag?.originalImage
        startButton.make(cornerRadius: 6)
        addSubview(contentView)
        
        //heightConstraint.constant *= Screen.ratio
        dialogView.layoutIfNeeded()
        setConstraint()
    }
    
    func setConstraint() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: contentView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: contentView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        contentView.layoutIfNeeded()
    }


    @IBAction func startAction(_ sender: UIButton) {
        removeFromSuperview()
        delegate?.start()
    }
}
