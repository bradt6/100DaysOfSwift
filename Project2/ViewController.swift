//
//  ViewController.swift
//  Project2
//
//  Created by Brad Thurlow on 20/2/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria",
        "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        askQuestion()
        
       
        
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) Score: \(score)"
        
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        let questionExhausted = "All questions answered"
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            totalAnswered += 1
        } else {
            title = "Wrong, the correct answer was flag at pos: \(correctAnswer)"
            score -= 1
            totalAnswered += 1
        }
        
        
        let ac = UIAlertController (title: title, message: "Your score is \(score)", preferredStyle: .alert)
        
        let doneAC = UIAlertController(title: questionExhausted, message: "You answered your \(totalAnswered) questions", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        if totalAnswered == 10{
            present(doneAC, animated: true)
        }
        
        present(ac, animated: true)
    }
    
    @objc func shareTapped () {
        
        let sharedScore = String(score)
        print ("******************************** \(sharedScore)")
        
        let vc = UIActivityViewController(activityItems: [sharedScore], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
    
}

