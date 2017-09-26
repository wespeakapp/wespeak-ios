//
//  UpdateProfileViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/23/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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

    @IBAction func onTapUpdateProfile(_ sender: UIButton) {
    }
}
