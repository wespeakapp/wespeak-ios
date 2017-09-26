//
//  EndCallPopup.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/25/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

protocol EndCallPopupDelegate: class {
    func endCall()
}

class EndCallPopup: UIView {

    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet var contentView: UIView!
    weak var delegate: EndCallPopupDelegate?
    
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
        let nib = UINib(nibName: String(describing: EndCallPopup.self), bundle: Bundle(for: EndCallPopup.self))
        nib.instantiate(withOwner: self, options: nil)
        dialogView.make(cornerRadius: 6)
        dialogView.make(shadowRadius: 6)
        endButton.make(cornerRadius: 6)
        contentView.frame = self.bounds
        addSubview(contentView)
    }
    
    @IBAction func endAction(_ sender: Any) {
        removeFromSuperview()
        delegate?.endCall()
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        removeFromSuperview()
    }
}
