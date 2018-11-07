//
//  CryptoViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/26/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CoreData
class CryptoViewController: UIViewController {
    
    var questionList = CryptoBank()
    
    var pickedQuestion = 0
    var uid = FIRAuth.auth()?.currentUser?.uid
    var questionNumber = 0
    var score = 0
    
    @IBOutlet weak var questionViewer: UILabel!
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    @IBOutlet weak var choiceThree: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionNumberView: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let questionNumberSaved = UserDefaults.standard.integer(forKey: "questionNumber")
            questionNumber = questionNumberSaved
        let scoreSaved = UserDefaults.standard.integer(forKey: "score")
            score = scoreSaved
            print(score, "is the score")
        update()
        
        view.setGradientBackground(oneColor: UIColor.blue , twoColor: UIColor.black)
        self.title = "Crypto Quiz"
        
        
        choiceOne.titleLabel?.textAlignment = NSTextAlignment.center
        choiceTwo.titleLabel?.textAlignment = NSTextAlignment.center
        choiceThree.titleLabel?.textAlignment = NSTextAlignment.center
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedQuestion = 1}
        else if sender.tag == 2 {
            pickedQuestion = 2}
        else if sender.tag == 3 {
            pickedQuestion = 3}
        checkAnswer()
        questionNumber += 1
        nextQuestion()
    }
    
    func checkAnswer(){
        let correctAnswer = questionList.cryptoBank[questionNumber].answer
        if pickedQuestion == correctAnswer {
            score += 100
        }else{
            print("Wrong Answer")
        }
    }
    
    func updateFirebase(){
        let ref = FIRDatabase.database().reference()
        guard let uid = FIRAuth.auth()?.currentUser!.uid else{
            return}
        ref.child("Users").child(uid).child("Cryptoquiz").child("Question Number").setValue(questionNumber)
        ref.child("Users").child(uid).child("Cryptoquiz").child("Score").setValue(score)
        UserDefaults.standard.set(questionNumber, forKey: "questionNumber")
        UserDefaults.standard.set(score, forKey: "score")
    }
    
    func nextQuestion(){
        if questionNumber <= 9 {
            update()
        } else{
            
            scoreLabel.text = "Score: \(score)"
            let alert = UIAlertController(title: "Done!", message: "Would you like to restart?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startAgain()
            })
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }}
    
    func update(){
        let nextQuest = questionList.cryptoBank[questionNumber]
        questionViewer.text = nextQuest.question
        choiceOne.setTitle(nextQuest.choice1, for: .normal)
        choiceTwo.setTitle(nextQuest.choice2, for: .normal)
        choiceThree.setTitle(nextQuest.choice3, for: .normal)
        scoreLabel.text = "Score: \(score)"
        questionNumberView.text = "Question: \(questionNumber + 1)"
        progressBarView.frame.size.width = (view.frame.size.width/10)  * CGFloat(questionNumber + 1)
        updateFirebase()
    }
    func startAgain(){
        score = 0
        questionNumber = 0
        update() 
    }
    }

