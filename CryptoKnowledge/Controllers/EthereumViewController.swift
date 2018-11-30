//
//  EthereumViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/17/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation


class EthereumViewController: UIViewController, AVAudioPlayerDelegate {
    
    let etherQuestions = EQBank()
    var questionNumber = 0
    var score = 0
    var pickedAnswer = 0
    let uid = FIRAuth.auth()?.currentUser?.uid
    var player = AVAudioPlayer()
    var wrongNoise = AVAudioPlayer()
    
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
     
        self.title = "Ethereum Quiz"
        choiceOne.titleLabel?.textAlignment = NSTextAlignment.center
        choiceTwo.titleLabel?.textAlignment = NSTextAlignment.center
        choiceThree.titleLabel?.textAlignment = NSTextAlignment.center 
        
        updateData() 
        questionTextField.text = etherQuestions.EqBank[questionNumber].question
        choiceOne.setTitle(etherQuestions.EqBank[questionNumber].choice1, for: .normal)
        choiceTwo.setTitle(etherQuestions.EqBank[questionNumber].choice2, for: .normal)
        choiceThree.setTitle(etherQuestions.EqBank[questionNumber].choice3, for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleSegueToCryptoChoice))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.gray]
        view.pushTransitionTop(1)
    }
    
    @objc func handleSegueToCryptoChoice(){
        performSegue(withIdentifier: "EtherBackToCoinChoice", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as? CryptoChoiceViewController
        vc?.etherScore = "\(score)"
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
            
            do {
                let avPlayer = Bundle.main.url(forResource: "393908__pogmog__money-collect-5", withExtension: "wav")
                player = try AVAudioPlayer(contentsOf: avPlayer!)
            } catch{
                print("Error with audio file")
            }
            
            player.play()
            score += 100
            scoreLabel.pushTransitionBottom(1) 
        }else {
            do{
                let avPlayer2 = Bundle.main.url(forResource: "basswronganswer", withExtension: "wav")
                wrongNoise = try AVAudioPlayer(contentsOf: avPlayer2!)
            }catch{
                print("Error with wrong audio") 
            }
            print("Wrong answer")
            wrongNoise.play() 
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
        questionNum.text = "Question: \(questionNumber + 1)/25"
        progressBar.frame.size.width = (view.frame.size.width/25) * CGFloat(questionNumber + 1)
        progressBar.backgroundColor = UIColor.gray.withAlphaComponent(0.30)
        progressBar.layer.cornerRadius = 5
        questionTextField.pushTransitionTop(1)
        questionNum.pushTransitionLeft(1)
        updateFirebase()
    }
    
    
    func nextQuestion() {
        if questionNumber <= 24 {
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
