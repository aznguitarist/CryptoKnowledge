//
//  MoneroViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 11/28/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation



class MoneroViewController: UIViewController,AVAudioPlayerDelegate {

    let moneroQuestions = MoneroBank()
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
    @IBOutlet weak var progressMeterView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackgroundspeical()
        view.pushTransitionLeft(1)
        let moneroQN = UserDefaults.standard.integer(forKey: "Monero QN")
        questionNumber = moneroQN
        let scoreSaved = UserDefaults.standard.integer(forKey: "Monero Score")
        score = scoreSaved
        
        self.title = " Monero Quiz"
        
        choiceOne.titleLabel?.textAlignment = NSTextAlignment.center
        choiceTwo.titleLabel?.textAlignment = NSTextAlignment.center
        choiceThree.titleLabel?.textAlignment = NSTextAlignment.center
        
        updateData()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleSegueToCryptoChoice))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layer.shadowColor = UIColor.darkGray.cgColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        choiceOne.layer.cornerRadius = 10
        choiceOne.backgroundColor = UIColor.darkGray
        
        choiceTwo.layer.cornerRadius = 10
        choiceTwo.backgroundColor = UIColor.darkGray
        
        choiceThree.layer.cornerRadius = 10
        choiceThree.backgroundColor = UIColor.darkGray
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
        performSegue(withIdentifier: "moneroBackToSelection", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as? CryptoChoiceViewController
        vc?.moneroScore = "\(score)"
    }
        
    
    func updateData(){
        let nextQuest = moneroQuestions.MoneroBank[questionNumber]
        //questionNumberLabel.text = " Question \(questionNumber + 1)/ 5"
        scoreLabel.text = "Score: \(score)"
        questionLabel.text = nextQuest.question
        choiceOne.setTitle(nextQuest.choice1, for: .normal)
        choiceTwo.setTitle(nextQuest.choice2, for: .normal)
        choiceThree.setTitle(nextQuest.choice3, for: .normal)
        progressLabel.text = "Question: \(questionNumber + 1)/25"
        progressMeterView.frame.size.width = (view.frame.size.width/25) * CGFloat(questionNumber + 1)
        progressMeterView.backgroundColor = UIColor.black.withAlphaComponent(0.70)
        progressMeterView.layer.cornerRadius = 8
        questionLabel.pushTransitionTop(1)
        progressLabel.pushTransitionRight(1) 
        updateFirebase()
    }
    func updateFirebase(){
        let ref = FIRDatabase.database().reference()
        ref.child("Users").child(uid!).child("Monero").child("Question").setValue(questionNumber)
        ref.child("Users").child(uid!).child("Monero").child("Score").setValue(score)
        
        UserDefaults.standard.set(questionNumber, forKey: "Monero QN")
        UserDefaults.standard.set(score, forKey: "Monero Score")
    }
    
    func checkAnswer(){
        if pickedAnswer == moneroQuestions.MoneroBank[questionNumber].answer{
            
            do {
                let avPlayer = Bundle.main.url(forResource: "393908__pogmog__money-collect-5", withExtension: "wav")
                player = try AVAudioPlayer(contentsOf: avPlayer!)
            } catch{
                print("Error with audio file")
            }
            
            player.play()
            score += 100
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
    
    func startAgain(){
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.layer.shadowColor = Colors.iconContrastYellow.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowRadius = 5
        navigationController?.navigationBar.layer.shadowOffset.height = 5
    }
    }
    

