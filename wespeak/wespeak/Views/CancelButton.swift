//
//  CancelButton.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/26/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

@IBDesignable
class CancelButton: UIButton {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleActionLabel: UILabel!
    
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
        let nib = UINib(nibName: String(describing: CancelButton.self), bundle: Bundle(for: CancelButton.self))
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = self.bounds
        addSubview(contentView)
    }
}
