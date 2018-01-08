//
//  LaunchViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/7/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        indicator.startAnimating()
        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        APIManager.shareInstance.getUser {
            result in
            switch result {
            case .success(let user):
                currentUser = user
                let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.indicator.stopAnimating()
                    appDelegate.window?.rootViewController = rootVC
                //})
                break
            case .failure(let error):
                print(error.message)
                break
            }
        }
    }
}
