//
//  BtcViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/17/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import RealmSwift

class BtcViewController: UIViewController  {
    
    let questionList = QuestionBank()
    var questionNumber : Int = 0
    var pickedAnswer : Int = 0
    var qScore : Int = 0
    
    var ref: FIRDatabaseReference? 
    
    @IBOutlet weak var questionTextField: UITextView!
    
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    @IBOutlet weak var choiceThree: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bitcoin Quiz"
        
        updateData()
//        questionTextField.layer.borderColor = UIColor.black.cgColor
//        questionTextField.layer.borderWidth = 2

//        self.applyRoundCorners(choiceOne)
        choiceOne.layer.borderColor = UIColor.black.cgColor
        choiceOne.layer.borderWidth = 0.5
        choiceOne.layer.cornerRadius = 20
        
        
        choiceTwo.layer.borderColor = UIColor.black.cgColor
        choiceTwo.layer.borderWidth = 0.5
        choiceTwo.layer.cornerRadius = 20
        
        choiceThree.layer.borderColor = UIColor.black.cgColor
        choiceThree.layer.borderWidth = 0.5
        choiceThree.layer.cornerRadius = 20 
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
    
    
 
    
    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1{
            pickedAnswer = 1    
        }
        else if sender.tag == 2 {
            pickedAnswer = 2
        }
        
        else if sender.tag == 3 {
            pickedAnswer = 3
        }
        
        
        checkAnswer()
        updateFirebase()
        questionNumber += 1
        nextQuestion()
    }
    
    func updateFirebase(){
        let ref = FIRDatabase.database().reference() 
        guard let uid = FIRAuth.auth()?.currentUser!.uid else{
            return}
        
        ref.child("Users").child(uid).child("Bitcoin Quiz").setValue(questionNumber)
    }
    
    func checkAnswer() {
        let correctAnswer = questionList.questionBank[questionNumber].answer
        if pickedAnswer == correctAnswer {
            qScore += 100
            print("correctAnswer")
            }
        else {
            print("Try again")
            }
        }
  
    func updateData() {
         let nextQuest = questionList.questionBank[questionNumber]
        questionNumberLabel.text = " Question \(questionNumber + 1)/ 15"
        scoreLabel.text = "Score: \(qScore)"
        questionTextField.text = nextQuest.question
        choiceOne.setTitle(nextQuest.choice1, for: .normal)
        choiceTwo.setTitle(nextQuest.choice2, for: .normal)
        choiceThree.setTitle(nextQuest.choice3, for: .normal)
        progressBar.frame.size.width = (view.frame.size.width/15) * CGFloat(questionNumber + 1)
    }
    
    func nextQuestion() {

        if questionNumber <= 14 {
            updateData()
            
        }else {
            scoreLabel.text = "Score: \(qScore)"
            let alert = UIAlertController(title: "You finished", message: "Would you like to play again?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func startOver() {
        questionNumber = 0
        qScore = 0
        nextQuestion()
    }
    
    func applyRoundCorners(_ Object: AnyObject){
        Object.layer.cornerRadius = Object.frame.size.width / 2
        Object.layer.masksToBounds = true
    }
    
    }
    
    

