//
//  FacebookLoginButton.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/22/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

@IBDesignable
class FacebookLoginButton: UIButton {

    @IBOutlet var contentView: UIView!
    
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
        let nib = UINib(nibName: String(describing: FacebookLoginButton.self), bundle: Bundle(for: FacebookLoginButton.self))
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = self.bounds
        let radius = contentView.frame.height/2
        contentView.make(cornerRadius: radius)
        self.addSubview(contentView)
    }

}
