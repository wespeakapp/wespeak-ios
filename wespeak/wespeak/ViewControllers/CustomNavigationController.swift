//
//  CustomNavigationController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/2/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationBar.barTintColor = Colors.mainColor
        //navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Colors.mainColor]
        // Do any additional setup after loading the view.
    }
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
}
