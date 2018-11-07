//
//  EthereumViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/17/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class EthereumViewController: UIViewController {
    
   let etherQuestions = EQBank()
    var questionNumber = 0
    var score = 0
    var pickedAnswer = 0
    let uid = FIRAuth.auth()?.currentUser?.uid
    
    @IBOutlet weak var questionTextField: UITextView!
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    @IBOutlet weak var choiceThree: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var questionNum: UILabel!
    
    
    override func viewDidLoad() {
        
        let etherQN = UserDefaults.standard.integer(forKey: "Ether QN")
        questionNumber = etherQN
        let scoreSaved = UserDefaults.standard.integer(forKey: "Ether Score")
        score = scoreSaved
        
        
        super.viewDidLoad()
        self.title = "Ethereum"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        updateData() 
        questionTextField.text = etherQuestions.EqBank[questionNumber].question
        choiceOne.setTitle(etherQuestions.EqBank[questionNumber].choice1, for: .normal)
        choiceTwo.setTitle(etherQuestions.EqBank[questionNumber].choice2, for: .normal)
        choiceThree.setTitle(etherQuestions.EqBank[questionNumber].choice3, for: .normal)
        
    }
    
    
    @IBAction func answeredPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = 1
        }
        
        else if sender.tag == 2 {
            pickedAnswer = 2
        }
        
        else if sender.tag == 3 {
            pickedAnswer = 3
        }
        checkAnswer()
        questionNumber += 1
        nextQuestion()
        
    }
    
    func updateFirebase(){
        let ref = FIRDatabase.database().reference()
        ref.child("Users").child(uid!).child("Ethereum").child("Question").setValue(questionNumber)
        ref.child("Users").child(uid!).child("Ethereum").child("Score").setValue(score)
        
        UserDefaults.standard.set(questionNumber, forKey: "Ether QN")
        UserDefaults.standard.set(score, forKey: "Ether Score")
    }
    
    
    func checkAnswer(){
        if pickedAnswer == etherQuestions.EqBank[questionNumber].answer{
            score += 1
        }else {
            print("Wrong answer")
        }
    }
    func updateData(){
        let nextQuest = etherQuestions.EqBank[questionNumber]
       //questionNumberLabel.text = " Question \(questionNumber + 1)/ 5"
        scoreLabel.text = "Score: \(score)"
        questionTextField.text = nextQuest.question
        choiceOne.setTitle(nextQuest.choice1, for: .normal)
        choiceTwo.setTitle(nextQuest.choice2, for: .normal)
        choiceThree.setTitle(nextQuest.choice3, for: .normal)
        questionNum.text = "Question: \(questionNumber + 1)/10"
        progressBar.frame.size.width = (view.frame.size.width/10) * CGFloat(questionNumber + 1)
        updateFirebase()
    }
    
    
    func nextQuestion() {
        if questionNumber <= 9 {
            
            updateData()
            
        }else{
            scoreLabel.text = " Score: \(score)"
            let alert = UIAlertController(title: "Finished", message: "Would you like to play again?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startAgain()
            })
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func startAgain() {
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    
    
    
}
