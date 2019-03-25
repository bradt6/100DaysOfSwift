//
//  ViewController.swift
//  consolidationDay5
//
//  Created by Brad Thurlow on 25/3/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var takenpictures = [CameraPics]()
    var name = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImage))
        
        let defaults = UserDefaults.standard
        
        if let savedPics = defaults.object(forKey: "takenPics") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                takenpictures = try jsonDecoder.decode([CameraPics].self, from: savedPics)
            } catch {
                print ("error loading pics")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return takenpictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = takenpictures[indexPath.row].file
        return cell
    }
    
    @objc func addImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {return}
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let chooseName = pickName()
        let pic = CameraPics(file: "unknown", image: imageName)
        takenpictures.append(pic)
        save()
        tableView.reloadData()
        dismiss(animated: true)
    }
    
    func pickName() -> String {
        let ac = UIAlertController(title: "Choose A Name", message: "name for your pic", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAnswer = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.name = answer
        }
        ac.addAction(submitAnswer)
        present(ac, animated: true)
        return name
    }
    
    
     func  getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = takenpictures[indexPath.row].image
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func save () {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(takenpictures) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "takenPics")
        } else {
            print("Failed to save people")
        }
    }

}

