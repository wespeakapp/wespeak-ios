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
    var countryCode: String!
    var searchResult = [Country]()
    var didSelectRow: ((_ countryCode: String) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension CountryPickerViewController: UITableViewDataSource, UITableViewDelegate {
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
        
        if cell.country?.code == countryCode {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.selectedCountry = { code in
            self.didSelectRow?(code)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
    }
}

extension CountryPickerViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResult = countries.filter { 
            $0.name.lowercased().contains(searchText.lowercased())
            || $0.code.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}
