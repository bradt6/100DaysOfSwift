//
//  DetailViewController.swift
//  Day 23 - milestone project
//
//  Created by Brad Thurlow on 24/2/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedImage!)
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
//        imageView.layer.backgroundColor = UIColor.black.cgColor

    }
    
    @objc func shareTapped () {
        
        if let shareFlag = selectedImage {
            
            let imageSelected = UIImage(named: shareFlag)
            
            let vc = UIActivityViewController(activityItems: [shareFlag, imageSelected!], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            
            present(vc, animated: true)
            
        }
        
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
