//
//  ReviewViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/27/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import Cosmos

class ReviewViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var feedbackTextField: UITextField!
    @IBOutlet weak var partnerRating: CosmosView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        profilePicture.make(cornerRadius: profilePicture.frame.height/2)
        profilePicture.clipsToBounds = true
        submitButton.make(cornerRadius: submitButton.frame.height/2)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "UnwindSegueToFindVC", sender: self)
        }
    }
}
