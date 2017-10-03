//
//  DetailConversationViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/2/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class DetailConversationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Jesica"
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "receiverCell") as! ReceiverCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell") as! SenderCell
            return cell
        }
    }
}
