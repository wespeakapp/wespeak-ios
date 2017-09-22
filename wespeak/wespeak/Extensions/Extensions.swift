//
//  Extensions.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/22/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

extension UIView {
    func make(cornerRadius: CGFloat = 0, boderWidth: CGFloat = 0, boderColor: UIColor = .clear) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = boderWidth
        layer.borderColor = boderColor.cgColor
    }
}
