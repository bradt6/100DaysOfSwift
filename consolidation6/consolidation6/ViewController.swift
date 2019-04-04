//
//  ViewController.swift
//  consolidation6
//
//  Created by Brad Thurlow on 1/4/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var country = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let path = Bundle.main.url(forResource: "countryData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                parse(json: data)
                return
            } catch {
                print("there was an error")
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonCountry = try? decoder.decode(Countries.self, from: json) {
            country = jsonCountry.country
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return country.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let countryName = country[indexPath.row]
        cell.textLabel?.text = countryName.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.detailItem = country[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

