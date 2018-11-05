//
//  EthereumViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/17/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

class EthereumViewController: UIViewController {
    
   let etherQuestions = EQBank()
    var questionNumber = 0
    var qScore = 0
    var pickedAnswer = 0
    
    
    @IBOutlet weak var questionTextField: UITextView!
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    @IBOutlet weak var choiceThree: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var questionNum: UILabel!
    
    
    override func viewDidLoad() {
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
    
    
    func checkAnswer(){
        if pickedAnswer == etherQuestions.EqBank[questionNumber].answer{
            qScore += 1 
        }else {
            print("Wrong answer")
        }
    }
    func updateData(){
        let nextQuest = etherQuestions.EqBank[questionNumber]
       //questionNumberLabel.text = " Question \(questionNumber + 1)/ 5"
        scoreLabel.text = "Score: \(qScore)"
        questionTextField.text = nextQuest.question
        choiceOne.setTitle(nextQuest.choice1, for: .normal)
        choiceTwo.setTitle(nextQuest.choice2, for: .normal)
        choiceThree.setTitle(nextQuest.choice3, for: .normal)
        questionNum.text = "Question: \(questionNumber + 1)/10"
        progressBar.frame.size.width = (view.frame.size.width/10) * CGFloat(questionNumber + 1)
    }
    
    
    func nextQuestion() {
        if questionNumber <= 9 {
            
            updateData()
            
        }else{
            scoreLabel.text = " Score: \(qScore)" 
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
        qScore = 0
        nextQuestion()
    }
    
    
    
}
