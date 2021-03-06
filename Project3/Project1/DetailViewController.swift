//
//  DetailViewController.swift
//  Project1
//
//  Created by Brad Thurlow on 18/2/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var chosenPic: Int?
    var picCount: Int?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//                title = selectedImage
        if let picNumber = chosenPic, let total = picCount {
            title = "\(picNumber) of \(total)"
            print(picNumber)
            print(total)
        }
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped(){
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("no image found")
            return
        }
        
        guard let text = selectedImage as? String else {
            print ("no text found")
            return
        }
        
        let items: [Any] = [image, text]
        

        
        print("**************************************************************")
        print(text)
        print(type(of: text))
        let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
