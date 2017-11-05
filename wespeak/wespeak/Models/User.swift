//
//  User.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/6/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import Foundation
import SwiftyJSON

var currentUser = User()
struct User {
    var id: String = ""
    var name: String = ""
    var email: String = ""
    var nativeLanguage: String = ""
    var about: String = ""
    var profilePicture: String = ""
    
    init() {}
    
    init(name:String, nativeLanguage:String, about:String) {
        self.name = name
        self.nativeLanguage = nativeLanguage
        self.about = about
    }
}

extension User {
    static func fromJSON(json: Any) -> User {
        let json = JSON(json)
        var user = User()
        if let id = json["_id"].string {
            user.id = id
        }
        if let name = json["name"].string {
            user.name = name
        }
        
        if let email = json["email"].string {
            user.email = email
        }
        
        if let language = json["nativeLanguage"].string {
            user.nativeLanguage = language
        }
        
        if let about = json["about"].string {
            user.about = about
        }
        
        if let url = json["avatarUrl"].string {
            user.profilePicture = url
        }
        return user
    }
}
