//
//  ViewController.swift
//  Project1
//
//  Created by Brad Thurlow on 17/2/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
     var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view, typically from a nib.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        pictures.sort()
        for i in pictures.indices{
            print("\(i + 1) out of \(pictures.count) with the name of: \(pictures[i])")
        }
        
//        print(pictures)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.picCount = pictures.count
            for i in pictures.indices {
                if vc.selectedImage == pictures[i] {
                vc.chosenPic = i + 1
                }
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

