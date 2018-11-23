//
//  RippleViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 11/13/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import AVFoundation
import UIKit
import Firebase

class RippleViewController: UIViewController, AVAudioPlayerDelegate {
    
    let rippleQuestionList = RippleBank()
    var pickedAnswer = 0
    var uid = FIRAuth.auth()?.currentUser?.uid
    var questionNumber = 0
    var score = 0
    var player = AVAudioPlayer()
    var wrongNoise = AVAudioPlayer()

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choiceOneButton: UIButton!
    @IBOutlet weak var choiceTwoButton: UIButton!
    @IBOutlet weak var choiceThreeButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var realProgressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(oneColor: UIColor.darkGray , twoColor: UIColor.blue)
        self.title = "Ripple Quiz"
//        let screenSize: CGRect = UIScreen.main.bounds
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 300))
//        navBar.heightAnchor =
////        let navItem = UINavigationItem(title: "Ripple")
//        //        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done))
//        //        navItem.rightBarButtonItem = doneItem
//
        
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleSegueToCryptoChoice))
      navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//
//        view.addSubview(navBar)
//        setNavigationBar()
        updateData()


    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "Ripple")
//        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done))
//        navItem.rightBarButtonItem = doneItem
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Backin it up", style: .plain, target: self, action: #selector(handleSegueToCryptoChoice))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.lightGray
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navBar.setItems([navItem], animated: false)
        view.addSubview(navBar)
    }
    
    @objc func handleSegueToCryptoChoice(){
        performSegue(withIdentifier: "rippleBackToCoinChoice", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as? CryptoChoiceViewController
        vc?.rippleScore = "\(score)"
        
    }
    @IBAction func choiceTapped(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = 1
        }
        else if sender.tag == 2 {
            pickedAnswer = 2
        }
       
        else if sender.tag == 3 {
            pickedAnswer = 3
        }
        print("Ripple \(questionNumber)")
        checkAnswer()
        questionNumber += 1
        nextQuestion()
    }
    
    func checkAnswer() {
        if pickedAnswer == rippleQuestionList.questionBank[questionNumber].answer {
            do {
                let avPlayer = Bundle.main.url(forResource: "393908__pogmog__money-collect-5", withExtension:"wav")
                player = try AVAudioPlayer(contentsOf: avPlayer!)
            } catch {
                print("Error with audio")
            }
            player.play()
            score += 100
        }
        else{
            do{
            let avPlayer2 = Bundle.main.url(forResource: "basswronganswer", withExtension: "wav")
            wrongNoise = try AVAudioPlayer(contentsOf: avPlayer2!)
            
        }catch{"Error with wrong audio"}
        wrongNoise.play()}
    }
    
    
    func updateData(){
      let nextQuestion = rippleQuestionList.questionBank[questionNumber]
        scoreLabel.text = "Score: \(score)"
        questionLabel.text = nextQuestion.question
        choiceOneButton.setTitle(nextQuestion.choice1, for: .normal)
        choiceTwoButton.setTitle(nextQuestion.choice2, for: .normal)
        choiceThreeButton.setTitle(nextQuestion.choice3, for: .normal)
        questionNumberLabel.text = "Question: \(questionNumber + 1)/12"
        progressBarView.frame.size.width = (view.frame.size.width/12) * CGFloat(questionNumber + 1)
        progressBarView.backgroundColor = UIColor.gray.withAlphaComponent(0.30)
       
    }
    
    func updateFirebase(){
        let ref = FIRDatabase.database().reference()
        guard let uid = FIRAuth.auth()?.currentUser!.uid else{
            return
        }
        ref.child("Users").child(uid).child("Ripple").child("Question").setValue(questionNumber)
            ref.child("Users").child(uid).child("Ripple").child("Score").setValue(score)
        UserDefaults.standard.set(questionNumber, forKey: "Ripple QN")
        UserDefaults.standard.set(score, forKey: "Ripple Score")
    }
    
    func nextQuestion(){
        if questionNumber <= 11 {
            updateData()
            
        }else{
            scoreLabel.text = "Score: \(score)"
            let alert = UIAlertController(title: "Finished", message: "Would you like to play again?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in self.startAgain()
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





//        view.backgroundColor = UIColor(displayP3Red: 100/255, green: 100/255, blue: 250/255, alpha: 1)
//        questionViewSetup()


//    func questionViewSetup() {
//        questionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        questionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
//        questionView.widthAnchor.constraint(equalToConstant: 250).isActive = true
//        questionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//
//    }




//    let questionView: UILabel = {
//        let view = UILabel()
//        view.backgroundColor = UIColor.white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 5
//        view.layer.masksToBounds = true
//        return view
//    }()
//
//    let choiceOneButton: UIButton = {
//        let oneButton = UIButton()
//        oneButton.title
//       return oneButton
//    }()
