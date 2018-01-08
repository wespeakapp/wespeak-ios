//
//  FirebaseManager.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 11/18/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import FirebaseDatabase

class FirebaseManager {
    
    var ref: DatabaseReference!
    
    func listenCallComming() {
        ref = Database.database().reference()
        ref.child("user").child("user1").observe(.value, with: {
            snapshot in
            let value = snapshot.value as! NSDictionary
            print(value)
        })
    }
}
