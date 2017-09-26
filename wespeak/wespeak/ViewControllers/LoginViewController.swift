//
//  ViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/22/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func onTapLogin(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileViewController
        
        present(vc, animated: true, completion: nil)
    }
}

