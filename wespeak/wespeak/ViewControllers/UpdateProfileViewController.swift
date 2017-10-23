//
//  UpdateProfileViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/23/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import AlamofireImage
import MBProgressHUD

class UpdateProfileViewController: UIViewController {

    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getUser()
    }
    
    func getUser() {
        APIManager.shareInstance.getUser {
            result in
            switch result {
            case .success(let user):
                self.nameTextField.text = user.name
                self.profileImageView.af_setImage(withURL: URL(string:user.profilePicture)!)
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func setupViews() {
        var radius = profileImageView.frame.height/2
        profileImageView.make(cornerRadius: radius)
        profileImageView.clipsToBounds = true
        
        radius = nameTextField.frame.height/2
        nameTextField.make(cornerRadius: radius, boderWidth: 1.4, boderColor: Colors.mainColor)
        
        radius = updateButton.frame.height/2
        updateButton.make(cornerRadius: radius)
    }

    @IBAction func onTapLanguageButton(_ sender: UIButton) {
        performSegue(withIdentifier: "CountryPickerVC", sender: self)
    }
    
    @IBAction func onTapUpdateProfile(_ sender: UIButton) {
        let user = User(name: nameTextField.text!, nativeLanguage: "Korean", about: "I want to imporove my english")
        let proressHub = MBProgressHUD.showAdded(to: self.view, animated: true)
        proressHub.label.text = "Updating..."
        APIManager.shareInstance.updateUser(user: user) {
            result in
            proressHub.hide(animated: true)
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
