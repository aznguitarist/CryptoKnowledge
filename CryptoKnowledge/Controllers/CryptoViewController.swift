//
//  CryptoViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/26/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

class CryptoViewController: UIViewController {
    
    var questionList = CryptoBank()
    var score = 0
    var questionNumber = 0
    var pickedQuestion = 0
    
    
    
    @IBOutlet weak var questionViewer: UILabel!
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    @IBOutlet weak var choiceThree: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionNumberView: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        choiceOne.titleLabel?.textAlignment = NSTextAlignment.center
        choiceTwo.titleLabel?.textAlignment = NSTextAlignment.center
        choiceThree.titleLabel?.textAlignment = NSTextAlignment.center 
        
        view.setGradientBackground(oneColor: UIColor.blue , twoColor: UIColor.black)
//        questionViewer.text = questionList.cryptoBank[questionNumber].question
//        choiceOne.setTitle(questionList.cryptoBank[questionNumber].choice1, for: .normal)
        
        update()
    }
    
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedQuestion = 1
        }
        else if sender.tag == 2 {
            pickedQuestion = 2
        }
        else if sender.tag == 3 {
            pickedQuestion = 3
        }
        checkAnswer()
        questionNumber += 1
        nextQuestion()
        
        
    }
    
    func checkAnswer(){
        let correctAnswer = questionList.cryptoBank[questionNumber].answer
        if pickedQuestion == correctAnswer {
            score += 1
        }else{
            print("Wrong Answer")
        }
    }
    
    func update(){
        
        var nextQuest = questionList.cryptoBank[questionNumber]
        
        questionViewer.text = nextQuest.question
        choiceOne.setTitle(nextQuest.choice1, for: .normal)
        choiceTwo.setTitle(nextQuest.choice2, for: .normal)
        choiceThree.setTitle(nextQuest.choice3, for: .normal)
        scoreLabel.text = "Score: \(score)"
        questionNumberView.text = "Question: \(questionNumber + 1)"
        progressBarView.frame.size.width = (view.frame.size.width/6)  * CGFloat(questionNumber + 1)
    
    }
    
    func nextQuestion(){
        
        if questionNumber <= 5 {
            update()
        } else{
            
            scoreLabel.text = "Score: \(score)"
            let alert = UIAlertController(title: "Done!", message: "Would you like to restart?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startAgain()
            })
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }

        }
    
    

    
    func startAgain(){
        score = 0
        questionNumber = 0
        update() 
    }
    
    
    }
 


