//
//  StoryboardManager.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 11/4/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class StoryboardManager: NSObject {
    
    static let sharedInstance = StoryboardManager()
    
    func getStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func getCallVC() -> CallViewController? {
        let storyboard = getStoryBoard()
        return storyboard.instantiateViewController(withIdentifier: "CallVC") as? CallViewController
    }
    
    func getRequestCallVC() -> RequestCallViewController? {
        let storyboard = getStoryBoard()
        return storyboard.instantiateViewController(withIdentifier: "RequestCallVC") as? RequestCallViewController
    }
}
