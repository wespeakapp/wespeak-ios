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
    var progressHub: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func onTapLogin(_ sender: UIButton) {
        progressHub = MBProgressHUD.showAdded(to: self.view, animated: true)
        fbLoginManager.logIn(withReadPermissions: ["email", "public_profile"], from: self) {
            (result, error) in
            
            if error != nil {
                return
            }
            
            guard let result = result else { return }
            if !result.isCancelled {
                //print(result.token.tokenString)

                APIManager.shareInstance.loginFB(token: result.token.tokenString) {
                    result in
                    //proressHub.hide(animated: true)
                    switch result {
                    case .success(_):
                        guard let country = Locale.current.regionCode else {return}
                        var user = User()
                        user.nativeLanguage = country
                        self.updateProfile(user: user)
                    case .failure(let error):
                        let alert = UIAlertController(title: "Login Fail", message: error.message, preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        break
                    }
                }
            } else {
                //Login fail
            }
        }
    }
    
    func updateProfile(user:User) {
        APIManager.shareInstance.updateUser(user: user) {
            result in
            self.progressHub.hide(animated: true)
            switch result {
            case .success(let user):
                currentUser = user
                let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = rootVC
            case .failure(let error):
                break
            }
    }
}
}
