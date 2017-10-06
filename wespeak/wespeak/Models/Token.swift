//
//  Token.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/4/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class Token {
    static var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "token")
        }
        set(token) {
            UserDefaults.standard.set(token, forKey: "token")
             UserDefaults.standard.synchronize()
        }
    }
}
