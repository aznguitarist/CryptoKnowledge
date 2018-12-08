//
//  CryptoViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/26/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class CryptoViewController: UIViewController, AVAudioPlayerDelegate {

    let questionList = CryptoBank()
    var pickedQuestion = 0
    var uid = FIRAuth.auth()?.currentUser?.uid
    var questionNumber = 0
    var score = 0
    var player = AVAudioPlayer()
    var wrongAnswerNoise = AVAudioPlayer()
    
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
        update()
        
       view.setGradientBackground(oneColor: UIColor.black , twoColor: UIColor.blue)
        self.title = "Blockchain"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:Colors.blue]
        
  
      
        view.pushTransitionLeft(1)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
      self.navigationController?.navigationBar.isTranslucent = true
//       self.navigationController?.view.backgroundColor = .clear
//        self.navigationItem.backBarButtonItem?.title = "Try Again"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector (handleCoinSelectionOut))
        navigationItem.leftBarButtonItem?.tintColor = Colors.blue
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowRadius = 5
        navigationController?.navigationBar.layer.shadowOffset.height = 5
    }
    
    @objc func handleCoinSelectionOut(){
      performSegue(withIdentifier: "BackToSelection", sender: self)
        view.pushTransitionLeft(5)
        questionViewer.pushTransitionRight(5)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as? CryptoChoiceViewController
        vc?.cryptoScore = "\(score)"
        updateFirebase()
        update()
     
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedQuestion = 1
            choiceOne.shake()
        }
        else if sender.tag == 2 {
            pickedQuestion = 2
            choiceTwo.flash()
        }
        else if sender.tag == 3 {
            pickedQuestion = 3
            choiceThree.pulsate()
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
        
        ref.child("Users").child(uid).child("Cryptoquiz").child("Question Number").setValue(questionNumber)
        ref.child("Users").child(uid).child("Cryptoquiz").child("Score").setValue(score)
        UserDefaults.standard.set(questionNumber, forKey: "questionNumber")
        UserDefaults.standard.set(score, forKey: "score")
    }
    
    func checkAnswer(){
        let correctAnswer = questionList.cryptoBank[questionNumber].answer
        if pickedQuestion == correctAnswer {
            
            do{
                let avPlayer = Bundle.main.url(forResource: "393908__pogmog__money-collect-5", withExtension: "wav")
                player = try AVAudioPlayer(contentsOf: avPlayer!)
            }catch{
                print("Audio Error")
            }
            player.play() 
            score += 100
            scoreLabel.pushTransitionBottom(1)
        }else{
            
            do{
                let avPlayer = Bundle.main.url(forResource: "basswronganswer", withExtension: "wav")
                wrongAnswerNoise = try AVAudioPlayer(contentsOf: avPlayer!)
            }catch{
                print("Audio Error")
                
            }
            wrongAnswerNoise.play()
            }
    }
    
    func nextQuestion(){
        if questionNumber <= 24 {
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
        
        progressBarView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        progressBarView.frame.size.width = (view.frame.size.width/25)  * CGFloat(questionNumber + 1)
        progressBarView.layer.cornerRadius = 9
        
        
        choiceOne.titleLabel?.textAlignment = NSTextAlignment.center
        choiceTwo.titleLabel?.textAlignment = NSTextAlignment.center
        choiceThree.titleLabel?.textAlignment = NSTextAlignment.center
        
        let nextQuest = questionList.cryptoBank[questionNumber]
        questionViewer.text = nextQuest.question
        questionViewer.pushTransitionTop(2)
        choiceOne.setTitle(nextQuest.choice1, for: .normal)
        choiceTwo.setTitle(nextQuest.choice2, for: .normal)
        choiceThree.setTitle(nextQuest.choice3, for: .normal)
        scoreLabel.text = "Score: \(score)"
        questionNumberView.text = "Question: \(questionNumber + 1)/25"
        progressBarView.frame.size.width = (view.frame.size.width/25)  * CGFloat(questionNumber + 1)
        questionNumberView.pushTransitionBottom(1)
    }
    
    func startAgain(){
        score = 0
        questionNumber = 0
        update() 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.layer.shadowColor = Colors.iconContrastYellow.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowRadius = 5
        navigationController?.navigationBar.layer.shadowOffset.height = 5
    }
    }

