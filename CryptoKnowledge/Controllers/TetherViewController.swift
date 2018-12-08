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
   
    
    let previousQuestion: UIButton = {
        let button = UIButton()
        button.setTitle("< Question", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.sizeToFit()
        //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(previousQ), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tag = 3
        
        return button
    }()
    
    let progressUI: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.layer.masksToBounds = true
        progress.trackTintColor = .clear
        progress.tintColor = UIColor.black.withAlphaComponent(0.5)
        progress.layer.borderColor = UIColor.gray.cgColor
        progress.layer.borderWidth = 2
        progress.layer.cornerRadius = 5
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        view.setGradientBackground(oneColor: Colors.tetherTurquoise, twoColor: UIColor.white)
        let tetherQN = UserDefaults.standard.integer(forKey: "Tether QN")
        questionNumber = tetherQN
        let scoreSaved = UserDefaults.standard.integer(forKey: "Tether Score")
        score = scoreSaved
        
        self.title = "Tether"

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleSegueToCryptoChoice))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        
        
        choiceOne.titleLabel?.textAlignment = NSTextAlignment.center
        choiceTwo.titleLabel?.textAlignment = NSTextAlignment.center
        choiceThree.titleLabel?.textAlignment = NSTextAlignment.center
      
        view.addSubview(choiceOne)
        view.addSubview(choiceTwo)
        view.addSubview(choiceThree)
        view.addSubview(previousQuestion)
        view.addSubview(scoreLabel)
        view.addSubview(questionLabel)
        view.addSubview(progressUI)
        viewSetup()
        updateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let navGradientImage = UIImage.gradientImageNav(with: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: 64), colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor,UIColor.darkGray.cgColor], locations: [0.66, 0.33])
        navigationController?.navigationBar.setBackgroundImage(navGradientImage, for: .default)
     
        
        let gradient = CAGradientLayer()
        gradient.frame = questionLabel.frame
        gradient.colors = [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.1)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.cornerRadius = 10
        view.layer.insertSublayer(gradient, at: 1)
        
        let firstGradientImage1 = UIImage.gradientImage1(with: choiceOne.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor,UIColor.darkGray.cgColor], locations: [0.66, 0.33])
        choiceOne.setBackgroundImage(firstGradientImage1, for: .normal)
        
        
        let secondButtonGradientImage = UIImage.gradientImage2(with:choiceTwo.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor], locations: [0.1, 0.8])
        choiceTwo.setBackgroundImage(secondButtonGradientImage, for: .normal)
        
        let threeButtonGradientImage = UIImage.gradientImage3(with: choiceTwo.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor,UIColor.darkGray.cgColor], locations: [0.33, 0.66])
        choiceThree.setBackgroundImage(threeButtonGradientImage, for: .normal)
        
        previousQuestion.setBackgroundImage(firstGradientImage1, for: .normal)
        
    }
    
    
    @IBAction func answerTapped(_ sender: AnyObject) {
        
        if sender.tag == 1 {pickedAnswer = 1}
        else if sender.tag == 2 {pickedAnswer = 2}
        else if sender.tag == 3 {pickedAnswer = 3}
        
        checkAnswer()
        questionNumber += 1
        nextQuestion()
    }
    func updateProgress(){
        let num = Double(questionNumber + 1) * 0.0625
        progressUI.setProgress(Float(num), animated: true)
        print(num)
        print("Question Number: \(questionNumber)")
    }
    
    @objc func handleSegueToCryptoChoice(){
        performSegue(withIdentifier: "tetherBackToCoinsChoice", sender: self)
    }
    
    @objc func previousQ() {
        if questionNumber == 0 {}
        else {questionNumber = questionNumber - 1}
        updateData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? CryptoChoiceViewController
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
        questionLabel.pushTransitionTop(1)
        updateProgress()
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
            } catch{ print("Error with audio file") }
            
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
        if questionNumber <= 15 {
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
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.layer.shadowColor = Colors.iconContrastYellow.cgColor
//        navigationController?.navigationBar.layer.shadowOpacity = 0.8
//        navigationController?.navigationBar.layer.shadowRadius = 5
//        navigationController?.navigationBar.layer.shadowOffset.height = 5
    }
    
    
//    func viewSetup() {
//        NSLayoutConstraint.activate([
//        questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//        questionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
//        questionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
//        questionLabel.heightAnchor.constraint(equalToConstant: 250),
//        choiceOne.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 15),
//        choiceOne.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
//        choiceOne.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15), choiceOne.heightAnchor.constraint(equalToConstant: 75), choiceTwo.topAnchor.constraint(equalTo: choiceOne.bottomAnchor, constant: 10),
//        choiceTwo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
//        choiceTwo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
//        choiceTwo.heightAnchor.constraint(equalToConstant: 75), choiceThree.topAnchor.constraint(equalTo: choiceTwo.bottomAnchor, constant: 10),
//        choiceThree.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
//        choiceThree.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
//        choiceThree.heightAnchor.constraint(equalToConstant: 75),
//        previousQuestion.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
//        previousQuestion.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: 5),
//        previousQuestion.heightAnchor.constraint(equalToConstant: 30),
//        previousQuestion.widthAnchor.constraint(equalToConstant: 100),
//        scoreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
//        scoreLabel.bottomAnchor.constraint(equalTo: progressUI.topAnchor),
//        scoreLabel.heightAnchor.constraint(equalToConstant: 30),
//        scoreLabel.widthAnchor.constraint(equalToConstant: 150),
//        progressUI.leftAnchor.constraint(equalTo: view.leftAnchor),
//        progressUI.rightAnchor.constraint(equalTo: view.rightAnchor),
//        progressUI.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        progressUI.heightAnchor.constraint(equalToConstant: 40) ])
//
//    }
    
    func viewSetup() {
//
//        questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
//        questionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
//        questionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
//        questionLabel.heightAnchor.constraint(equalToConstant: 250).isActive = true
//        view.addSubview(questionLabel)


//
//        choiceOne.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 15).isActive = true
//        choiceOne.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
//        choiceOne.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
//        choiceOne.heightAnchor.constraint(equalToConstant: 75).isActive = true
//        view.addSubview(choiceOne)
//
//        choiceTwo.topAnchor.constraint(equalTo: choiceOne.bottomAnchor, constant: 10).isActive = true
//        choiceTwo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
//        choiceTwo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
//        choiceTwo.heightAnchor.constraint(equalToConstant: 75).isActive = true
//        view.addSubview(choiceTwo)
//
//        choiceThree.topAnchor.constraint(equalTo: choiceTwo.bottomAnchor, constant: 10).isActive = true
//        choiceThree.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
//        choiceThree.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
//        choiceThree.heightAnchor.constraint(equalToConstant: 75).isActive = true
//        view.addSubview(choiceThree)

//        buttonStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
//        buttonStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
//        buttonStack.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        buttonStack.bottomAnchor.constraint(equalTo: previousQuestion.topAnchor, constant: -10).isActive = true
//        view.addSubview(buttonStack)


        previousQuestion.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        previousQuestion.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: 5).isActive = true
        previousQuestion.heightAnchor.constraint(equalToConstant: 30).isActive = true
        previousQuestion.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.addSubview(questionLabel)

//        scoreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
//        scoreLabel.bottomAnchor.constraint(equalTo: progressUI.topAnchor).isActive = true
//        scoreLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        scoreLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        view.addSubview(scoreLabel)

        progressUI.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        progressUI.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        progressUI.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        progressUI.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.addSubview(progressUI)

    }
    
}



// TODO: Gradient UIImage extension
fileprivate extension UIImage {
    static func gradientImage1(with bounds: CGRect,
                               colors: [CGColor],
                               locations: [NSNumber]?) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.cornerRadius = 10
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image}
    
    static func gradientImage2(with bounds: CGRect, colors: [CGColor], locations: [NSNumber]?) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
         gradientLayer.cornerRadius = 10
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
    static func gradientImage3(with bounds: CGRect, colors: [CGColor], locations: [NSNumber]?) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0,  y: 1.0)
         gradientLayer.cornerRadius = 10
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
    static func gradientImageNav(with bounds: CGRect, colors: [CGColor], locations: [NSNumber]?) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 1.0,  y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.cornerRadius = 0
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
}
