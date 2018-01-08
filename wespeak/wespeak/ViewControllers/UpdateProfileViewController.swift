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
    
    var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        //setupUI()
        //getUser()
    }
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func getUser() {
        APIManager.shareInstance.getUser {
            result in
            switch result {
            case .success(let user):
                self.user = user
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
        
        nameTextField.text = user.name
        if let url = URL(string:user.profilePicture) {
            profileImageView.af_setImage(withURL: url)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CountryPickerViewController {
            vc.countryCode = "US"
            vc.didSelectRow = {code in print(code)}
        }
    }
    @IBAction func onTapLanguageButton(_ sender: UIButton) {
        performSegue(withIdentifier: "CountryPickerVC", sender: self)
    }
    
    @IBAction func onTapUpdateProfile(_ sender: UIButton) {
        let newUser = User(name: nameTextField.text!, nativeLanguage: user.nativeLanguage, about: "I want to imporove my english")
        let proressHub = MBProgressHUD.showAdded(to: self.view, animated: true)
        proressHub.label.text = "Updating..."
        APIManager.shareInstance.updateUser(user: newUser) {
            result in
            proressHub.hide(animated: true)
            switch result {
                case .success(let user):
                    currentUser = user
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print(error.message)
                    break
            }
        }
    }
}
