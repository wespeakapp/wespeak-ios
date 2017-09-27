//
//  FindPartnerViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/23/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import KDCircularProgress

class FindPartnerViewController: UIViewController {

    @IBOutlet weak var heightFindButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var findPartnerButton: UIButton!

    let titleFind = "Let find an English speaking partner!"
    let titleFinding = "We are connecting you with a partner!"
    var progress: KDCircularProgress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        heightFindButtonConstraint.constant *= Screen.ratio
        findPartnerButton.layoutIfNeeded()
        let radius = findPartnerButton.frame.height/2
        findPartnerButton.make(cornerRadius: radius, boderWidth: 2.0, boderColor: Colors.mainColor)
        //addCircle()
    }

    @IBAction func stopFindAction(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            self.blurView.alpha = 0
            self.findPartnerButton.isEnabled = true
            self.findPartnerButton.setTitle("Search", for: .normal)
            self.findPartnerButton.backgroundColor = Colors.mainColor
            self.titleLabel.text = self.titleFind
            guard let tabbar = self.tabBarController?.tabBar else { return }
            tabbar.transform = CGAffineTransform(translationX: tabbar.frame.origin.x, y: 0)
        }, completion: {
            completed in
            self.performSegue(withIdentifier: "CallVCSegue", sender: self)
        })
    }
    
    @IBAction func findAction(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            self.blurView.alpha = 1
            self.findPartnerButton.isEnabled = false
            self.findPartnerButton.backgroundColor = UIColor.clear
            self.findPartnerButton.setTitle("Searching...", for: .normal)
            self.titleLabel.text = self.titleFinding
            guard let tabbar = self.tabBarController?.tabBar else { return }
            tabbar.transform = CGAffineTransform(translationX: tabbar.frame.origin.x, y: tabbar.frame.height)
        }, completion: nil)
        //animate()
    }
    
    func animate() {
        progress.animate(fromAngle: 0, toAngle: 360, duration: 5) {
            completed in
            if completed {
                self.animate()
            }
        }
    }
    func addCircle() {
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        progress.startAngle = -90
        progress.progressThickness = 0.1
        progress.trackThickness = 0.2
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = false
        progress.glowMode = .forward
        progress.glowAmount = 0.9
        progress.trackColor = UIColor.gray
        progress.progressInsideFillColor = UIColor.clear
        //progress.set(colors: UIColor.cyan ,UIColor.white, UIColor.magenta, UIColor.white, UIColor.orange)
        progress.set(colors: UIColor.clear, Colors.mainColor, UIColor.clear)
        progress.center = CGPoint(x: view.center.x, y: view.center.y + 25)
        view.addSubview(progress)
    }
    
    @IBAction func unwindToFindVC(segue:UIStoryboardSegue) { }
}
