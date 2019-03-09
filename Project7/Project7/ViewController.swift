//
//  ViewController.swift
//  Project7
//
//  Created by Brad Thurlow on 6/3/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var searchedPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        let infoButton = UIButton(type: .infoLight)
        
        infoButton.addTarget(self, action: #selector(showCredits), for: .touchUpInside)
        
        let infoBarButton = UIBarButtonItem(customView: infoButton)
        
        navigationItem.rightBarButtonItem = infoBarButton
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(searchForAnswer))
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
               parse(json: data)
                return
            }
        }
        showError()
    }
    
    @objc func searchForAnswer () {
        let ac = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAnswer = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac ] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAnswer)
        present(ac, animated: true)
    }
    
    func submit (_ answer: String) {
        let lowerAnswer = answer.lowercased()
        print(lowerAnswer)
        print(petitions.count)
        
        petitions = searchedPetitions.filter {
            $0.title.lowercased().contains(lowerAnswer)
        }
        tableView.reloadData()
    }
    
    @objc func showCredits () {
        let ac = UIAlertController(title: "Data has been received from", message: "The people api", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Done", style: .default))
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: reload))
        present(ac, animated: true)
    }
    
    func reload (default: UIAlertAction) {
        petitions = searchedPetitions
        tableView.reloadData()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was an error loading your content", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            searchedPetitions = petitions
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

