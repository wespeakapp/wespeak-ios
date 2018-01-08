//
//  ProfileViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 9/27/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCells()
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UpdateProfileViewController {
            vc.user = currentUser
        }
    }
    @IBAction func onEditAction(_ sender: UIBarButtonItem) {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc = storyboard.instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileViewController
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    func initCells() {
        tableView.register(UINib(nibName: String(describing: ProfileCell.self), bundle: nil) , forCellReuseIdentifier: "ProfileCell")
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
        cell.user = currentUser
        return cell
    }
}
