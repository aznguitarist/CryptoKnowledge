//
//  TetherViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 11/30/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVFoundation

class TetherViewController: UIViewController, AVAudioPlayerDelegate {
    
    let tetherQuestions = TetherBank()
    var questionNumber = 0
    var score = 0
    var pickedAnswer = 0
    let uid = FIRAuth.auth()?.currentUser?.uid
    var player = AVAudioPlayer()
    var wrongNoise = AVAudioPlayer()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    @IBOutlet weak var choiceThree: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressMeterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(oneColor: Colors.tetherTurquoise, twoColor: UIColor.white)
        view.pushTransitionLeft(1)
        let tetherQN = UserDefaults.standard.integer(forKey: "Tether QN")
        questionNumber = tetherQN
        let scoreSaved = UserDefaults.standard.integer(forKey: "Tether Score")
        score = scoreSaved
        
        self.title = "Tether"
        
        choiceOne.titleLabel?.textAlignment = NSTextAlignment.center
        choiceTwo.titleLabel?.textAlignment = NSTextAlignment.center
        choiceThree.titleLabel?.textAlignment = NSTextAlignment.center
        
       updateData()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleSegueToCryptoChoice))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
    }
    
    
    @IBAction func answerTapped(_ sender: AnyObject) {
        
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
    
    @objc func handleSegueToCryptoChoice(){
        performSegue(withIdentifier: "tetherBackToCoinsChoice", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as? CryptoChoiceViewController
        vc?.tetherScore = "\(score)"
    }
    
    func updateData(){
        let nextQuest = tetherQuestions.TetherBank[questionNumber]
        //questionNumberLabel.text = " Question \(questionNumber + 1)/ 5"
        scoreLabel.text = "Score: \(score)"
        questionLabel.text = nextQuest.question
        choiceOne.setTitle(nextQuest.choice1, for: .normal)
        choiceTwo.setTitle(nextQuest.choice2, for: .normal)
        choiceThree.setTitle(nextQuest.choice3, for: .normal)
        progressLabel.text = "Question: \(questionNumber + 1)/16"
        progressMeterView.frame.size.width = (view.frame.size.width/16) * CGFloat(questionNumber + 1)
        progressMeterView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.70)
        progressMeterView.layer.cornerRadius = 8
        questionLabel.pushTransitionTop(1)
        progressLabel.pushTransitionLeft(1)
        updateFirebase()
    }
    func updateFirebase(){
        let ref = FIRDatabase.database().reference()
        ref.child("Users").child(uid!).child("Tether").child("Question").setValue(questionNumber)
        ref.child("Users").child(uid!).child("Tether").child("Score").setValue(score)
        
        UserDefaults.standard.set(questionNumber, forKey: "Tether QN")
        UserDefaults.standard.set(score, forKey: "Tether Score")
    }
    
    func checkAnswer(){
        if pickedAnswer == tetherQuestions.TetherBank[questionNumber].answer{
            
            do {
                let avPlayer = Bundle.main.url(forResource: "393908__pogmog__money-collect-5", withExtension: "wav")
                player = try AVAudioPlayer(contentsOf: avPlayer!)
            } catch{
                print("Error with audio file")
            }
            
            player.play()
            score += 100
            scoreLabel.pushTransitionTop(1)
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
    
    func nextQuestion() {
        if questionNumber <= 16 {
            
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
    
    func startAgain(){
        questionNumber = 0
        score = 0
        nextQuestion()
    }
}
