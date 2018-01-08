//
//  Conversation.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/29/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//
import SwiftyJSON

enum ConversationSatus: String {
    case Watting = "Waitting"
}

class Conversation {
    var id: String = ""
    var status: String = ""
    var sessionId: String = ""
    var token: String = ""
    var partner: User = User()
    
    init() {
        
    }
    
    init(json: JSON) {
        id = json["_id"].stringValue
        status = json["status"].stringValue
        sessionId = json["sessionId"].stringValue
        token = json["userOTToken"].stringValue
        let partnerToken = json["partnerOTToken"].stringValue
        
        if token != partnerToken {
            print("partnerToken: \(partnerToken)")
        } else {
            print("Tokens is the same")
        }
        if let json = json["partnerId"].dictionaryObject {
            partner = User.fromJSON(json: json)
        }
    }
}
