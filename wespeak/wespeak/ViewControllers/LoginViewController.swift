//
//  ViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/22/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import MBProgressHUD

class LoginViewController: UIViewController {

    var fbLoginManager = FBSDKLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func onTapLogin(_ sender: UIButton) {
        fbLoginManager.logIn(withReadPermissions: ["email", "public_profile"], from: self) {
            (result, error) in
            
            if error != nil {
                return
            }
            
            guard let result = result else { return }
            if !result.isCancelled {
                //print(result.token.tokenString)
                let proressHub = MBProgressHUD.showAdded(to: self.view, animated: true)
                APIManager.shareInstance.loginFB(token: result.token.tokenString) {
                    result in
                    proressHub.hide(animated: true)
                    switch result {
                    case .success(_):
                        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileViewController
                        self.present(vc, animated: true, completion: nil)
                    case .failure(_):
                        break
                    }
                }
            } else {
                //Login fail
            }
        }
    }
}

