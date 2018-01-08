//
//  RequestCallViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 11/19/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class RequestCallViewController: UIViewController {

    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        //profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
    
    @IBAction func onAcceptTap(_ sender: UIButton) {
    
    }
}
