//
//  CallViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/25/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class CallViewController: UIViewController {

    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        showMatchedPopup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMatchedPopup() {
        let popup = MatchedPopup(frame: CGRect(x: 0, y: 0, width: Screen.size.width, height: Screen.size.height))
        self.view.addSubview(popup)
        popup.delegate = self
    }
    
    @IBAction func turnoffMicAction(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
        } else {
            sender.isSelected = false
        }
    }
    
    @IBAction func turnoffCameraAction(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
        } else {
            sender.isSelected = false
        }
    }
    
    @IBAction func endCallAction(_ sender: UIButton) {
        let popup = EndCallPopup(frame:  CGRect(x: 0, y: 0, width: Screen.size.width, height: Screen.size.height))
        popup.delegate = self
        view.addSubview(popup)
    }
}

extension CallViewController: MatchedPopupDelegate {
    func start() {
        //dismiss(animated: true, completion: nil)
    }
}

extension CallViewController: EndCallPopupDelegate {
    func endCall() {
        performSegue(withIdentifier: "ReviewVCSegue", sender: self)
    }
}
