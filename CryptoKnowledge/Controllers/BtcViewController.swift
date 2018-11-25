//
//  BtcViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/17/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//


import UIKit
import Firebase
import AVFoundation


class BtcViewController: UIViewController, AVAudioPlayerDelegate  {
    
    let questionList = BitcoinBank()
    var questionNumber : Int = 0
    var pickedAnswer : Int = 0
    var score : Int = 0
    var ref: FIRDatabaseReference?
    var player = AVAudioPlayer()
    var wrongNoise = AVAudioPlayer() 
    
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
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        
        
        let questionNumberSaved = UserDefaults.standard.integer(forKey: "Btc Question Number")
            questionNumber = questionNumberSaved
        let scoreSaved = UserDefaults.standard.integer(forKey: "BTC Score")
            score = scoreSaved
         progressBar.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        
        updateData()
//        questionTextField.layer.borderColor = UIColor.black.cgColor
//        questionTextField.layer.borderWidth = 2

//        self.applyRoundCorners(choiceOne)
//        choiceOne.layer.borderColor = UIColor.black.cgColor
//        choiceOne.layer.borderWidth = 0.5
//        choiceOne.layer.cornerRadius = 20
            choiceOne.titleLabel?.textAlignment = NSTextAlignment.center
            choiceTwo.titleLabel?.textAlignment = NSTextAlignment.center
            choiceThree.titleLabel?.textAlignment = NSTextAlignment.center
        
            progressBar.layer.cornerRadius = 5
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCoinSelectionOut))
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        
    }
    
    @objc func handleCoinSelectionOut(){
        performSegue(withIdentifier: "BtcBackToCoinChoice", sender: self)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as? CryptoChoiceViewController
        vc?.btcScore = "\(score)"
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
        
    ref.child("Users").child(uid).child("BTC").child("Bitcoin Quiz").setValue(questionNumber)
        ref.child("Users").child(uid).child("BTC").child("Score").setValue(score)
        UserDefaults.standard.set(questionNumber, forKey: "Btc Question Number")
        UserDefaults.standard.set(score, forKey: "BTC Score")
    }
    
    func checkAnswer() {
        let correctAnswer = questionList.questionBank[questionNumber].answer
        if pickedAnswer == correctAnswer {
            
            do{
                let avPlayer = Bundle.main.url(forResource: "393908__pogmog__money-collect-5", withExtension: "wav")
                player = try AVAudioPlayer(contentsOf: avPlayer!)
            } catch {
                print("Error with audio")
            }
            player.play()
            score += 100
            }
        else {
            do{
                let avPlayer2 = Bundle.main.url(forResource: "basswronganswer", withExtension: "wav")
            wrongNoise = try AVAudioPlayer(contentsOf: avPlayer2!)
            }catch{"Error with audio"}
            
            print("Try again")
            wrongNoise.play() 
        }
        }
  
    func updateData() {
         let nextQuest = questionList.questionBank[questionNumber]
        questionNumberLabel.text = " Question \(questionNumber + 1)/ 15"
        scoreLabel.text = "Score: \(score)"
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
            scoreLabel.text = "Score: \(score)"
            let alert = UIAlertController(title: "You finished", message: "Would you like to play again?", preferredStyle: .alert)
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
    
    func applyRoundCorners(_ Object: AnyObject){
        Object.layer.cornerRadius = Object.frame.size.width / 2
        Object.layer.masksToBounds = true
    }
    
    }
    
    

