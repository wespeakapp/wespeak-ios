//
//  Language.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/14/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import Foundation

class Country {
    let name: String
    let code: String
    
    init(name:String, code:String) {
        self.name = name
        self.code = code
    }
    
    static func getCountries() -> [Country]{
        var result = [Country]()
        if let path = Bundle.main.url(forResource: "CountryCode", withExtension: "plist") {
            let countries = NSArray(contentsOf: path) as? [Dictionary<String, String>]
            for country in countries! {
                if let name = country["name"], let code = country["code"] {
                    result.append(Country(name: name, code: code))
                }
            }
        }
        return result
    }
}
