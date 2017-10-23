//
//  CountryPickerViewController.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/14/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class CountryPickerViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let countries = Country.getCountries()
    var searchResult = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }

}

extension CountryPickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResult.count > 0 {
            return searchResult.count
        } else {
            return countries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryCell
        if searchResult.count > 0 {
            cell.country = searchResult[indexPath.row]
        } else {
            cell.country = countries[indexPath.row]
        }
        return cell
    }
}

extension CountryPickerViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResult = countries.filter { $0.name.contains(searchText)}
        tableView.reloadData()
    }
}
