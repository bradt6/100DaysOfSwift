//
//  ViewController.swift
//  ConsolidationDay41
//
//  Created by Brad Thurlow on 14/3/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedLetters = [String]()
    var correctScore = 0
    var choosenWord = ""
    var wrongAnswers = 0 {
        didSet {
            title = "Word: \(promptWord) Wrong: \(wrongAnswers) / 7"
        }
    }
    var promptWord = "" {
        didSet {
            title = "Word: \(promptWord) Wrong \(wrongAnswers) / 7"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["RHYTHM"]
        }
        startGame()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedLetters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeLetter", for: indexPath)
        cell.textLabel?.text = usedLetters[indexPath.row]
        return cell
    }
    
    @objc func startGame() {
//        title = allWords.randomElement()
        choosenWord = ""
        promptWord = ""

        if let pickedWord = allWords.randomElement() {
            choosenWord = pickedWord
            print(choosenWord)
            print(choosenWord.count)
            for _ in choosenWord {
                promptWord += "?"
            }
        }
        usedLetters.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptForAnswer () {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        
        if answer.count > 1 {
            let ac = UIAlertController (title: "To Long", message: "You can only enter one letter at a time", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }

        usedLetters.insert(answer, at: 0)
        
        if (!choosenWord.contains(answer)) {
            wrongAnswers += 1
            print("wrong \(wrongAnswers)")
        }
        
        if (wrongAnswers == 7) {
            let ac = UIAlertController(title: "You Lost", message: "You have Lost", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "New Game", style: .default, handler:  { _ in
                self.startGame()
            }))
            present(ac,animated: true)
        }

        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        checkIfCorrent()
        
        return
    }
    
    func checkIfCorrent(){
        promptWord = ""
        correctScore = 0
        for letter in choosenWord {
            let strLetter = String(letter)
            
            if usedLetters.contains(strLetter) {
                correctScore += 1
                promptWord += strLetter
            } else {
                promptWord  += "?"
            }
        }
        print(correctScore)
        if (choosenWord.count == correctScore) {
            let ac = UIAlertController(title: "You Wil", message: "You have Won", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "New Game", style: .default, handler:  { _ in
                self.startGame()
                }))
//            ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: #selector(startGame)))
            present(ac, animated: true)
        }
    }
    
}

