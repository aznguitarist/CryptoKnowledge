//
//  DashViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 12/5/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVFoundation

class DashViewController: UIViewController, AVAudioPlayerDelegate {
    
    let dashQuestions = DashBank()
    var questionNumber = 0
    var score = 0
    var pickedAnswer = 0
    let uid = FIRAuth.auth()?.currentUser?.uid
    var player = AVAudioPlayer()
    var wrongNoise = AVAudioPlayer()
    var progressValue = 0.0
    
    // TODO: View Setup
    let navBarView: UIView = {
        let navBar = UIView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.layer.masksToBounds = true
        //        navBar.gradientEos(oneColor: UIColor.lightGray, twoColor: UIColor.blue)
        return navBar
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("< Back", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = "DASH"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        return label
    }()
    
    // TODO: Views List
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.textColor = UIColor.white
        label.textAlignment = .center
        //        label.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        label.font = label.font.withSize(30)
        label.adjustsFontSizeToFitWidth = true
//        label.backgroundColor = UIColor.darkGray
        label.layer.cornerRadius = 5
        label.numberOfLines = 5
        return label
    }()
    //    TODO: Choices View
    let choiceOne: UIButton = {
        let button = UIButton()
        button.setTitle("One", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.titleLabel?.numberOfLines = 3
        button.tag = 1
        //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(answerOne), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        
        return button
    }()
    let choiceTwo: UIButton = {
        let button = UIButton()
        button.setTitle("Two", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.titleLabel?.numberOfLines = 3
        //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(answerTwo), for: .touchUpInside)
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tag = 2
        
        return button
    }()
    let choiceThree: UIButton = {
        let button = UIButton()
        button.setTitle("Three", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.titleLabel?.numberOfLines = 3
        //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(answerThree), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tag = 3
        
        return button
    }()
    // TODO: BottomView
    
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
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = "Score: "
        label.textColor = UIColor.black
        label.textAlignment = .left
        //        label.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        label.font = label.font.withSize(20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let questionNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = "Question"
        label.textColor = UIColor.black
        label.textAlignment = .center
        //        label.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        label.font = label.font.withSize(20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 5
        return label
    }()
    
    let progressUI: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.layer.masksToBounds = true
        progress.trackTintColor = .clear
        progress.layer.borderWidth = 2
        progress.layer.borderColor = Colors.iconDarkBlue.cgColor
        progress.tintColor = UIColor.black.withAlphaComponent(0.5)
        return progress
    }()
    
    
 
    
    // TODO: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.setGradientBackgroundDash()
        view.backgroundColor = Colors.dashBlue
        //        self.perform(#selector(updateProgress), with: nil, afterDelay: 0.01)
        view.addSubview(navBarView)
        view.addSubview(choiceOne)
        view.addSubview(choiceTwo)
        view.addSubview(choiceThree)

        view.addSubview(questionLabel)
        view.addSubview(previousQuestion)
        view.addSubview(scoreLabel)
        view.addSubview(questionNumberLabel)
        
        view.addSubview(progressUI)
        
  
        setNavigationBar()
        viewSetup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        navBarView.navGradientDash(oneColor: UIColor.darkGray, twoColor: Colors.dashBlue, threeColor: Colors.dashBlue)
        //        progressUI.setGradientBackground4(oneColor: UIColor.black, twoColor: UIColor.white, threeColor: UIColor.black)
        
        let navGradient = CAGradientLayer()
        navGradient.frame = navBarView.frame
        navGradient.colors = [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
//        navGradient.locations = [0.66, 0.33]
        navGradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        navGradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        view.layer.insertSublayer(navGradient, at: 0)
        
        let gradient = CAGradientLayer()
            gradient.frame = questionLabel.frame
            gradient.colors = [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.1)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.cornerRadius = 10
            view.layer.insertSublayer(gradient, at: 1)
        
          let firstGradientImage1 = UIImage.gradientImage(with: choiceTwo.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor,UIColor.darkGray.cgColor], locations: [0.66, 0.33])
            choiceOne.setBackgroundImage(firstGradientImage1, for: .normal)
        let secondButtonGradientImage = UIImage.gradientImage2(with:choiceTwo.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor], locations: [0.1, 0.8])
                choiceTwo.setBackgroundImage(secondButtonGradientImage, for: .normal)
         let threeButtonGradientImage = UIImage.gradientImage3(with: choiceTwo.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor,UIColor.darkGray.cgColor], locations: [0.33, 0.66])
        choiceThree.setBackgroundImage(threeButtonGradientImage, for: .normal)
        
        previousQuestion.setBackgroundImage(firstGradientImage1, for: .normal)
        
        
        let gradientImage = UIImage.gradientImage(with: progressUI.frame, colors: [UIColor.black.withAlphaComponent(0.25).cgColor,UIColor.lightGray.cgColor, UIColor.black.withAlphaComponent(0.25).cgColor], locations: [0.0,0.1,0.5])
        progressUI.progressImage = gradientImage!
        
        updateData()
    }
    
    // TODO: object C
    @objc func updateProgress(){
        //        var num = eosQuestions.EOSBank[questionNumber]
        let num = Double(questionNumber + 1) * 0.04
        progressUI.setProgress(Float(num), animated: true)
        
        print(progressValue)
        print(num)
        print("Question Number: \(questionNumber)")
    }
    
    @objc func answerOne() {
        pickedAnswer = 1
        checkAnswers()
        questionNumber += 1
        nextQuestion()
    }
    @objc func answerTwo(){
        pickedAnswer = 2
        checkAnswers()
        questionNumber += 1
        nextQuestion()
    }
    
    @objc func answerThree(){
        pickedAnswer = 3
        checkAnswers()
        questionNumber += 1
        nextQuestion()
    }
    
    @objc func back() { 
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
       let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") 
        present(mainRegistrationVC, animated: true, completion: nil)
    }
    
    @objc func previousQ() {
        if questionNumber == 0 {}
        else {questionNumber = questionNumber - 1}
        updateData()
    }
    
    func checkAnswers() {
        if pickedAnswer == dashQuestions.DashBank[questionNumber].answer{
            
            do {
                let avPlayer = Bundle.main.url(forResource: "393908__pogmog__money-collect-5", withExtension: "wav")
                player = try AVAudioPlayer(contentsOf: avPlayer!)
            } catch{
                print("Error with audio file")
            }
            
            player.play()
            
            if score < 10000 {score += 100}
            scoreLabel.pushTransitionTop(1)
        }
        else {
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
        updateFirebase()
        updateProgress()
        let nextQuest = dashQuestions.DashBank[questionNumber]
        scoreLabel.text = "Score: \(score)"
        questionLabel.text = nextQuest.question
        choiceOne.setTitle(nextQuest.choice1, for: .normal)
        choiceTwo.setTitle(nextQuest.choice2, for: .normal)
        choiceThree.setTitle(nextQuest.choice3, for: .normal)
        questionNumberLabel.text = "Question: \(questionNumber + 1)/26"
        //        progressView.frame.size.width = (view.frame.size.width/25) * CGFloat(questionNumber + 1)
        //        progressView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.70)
        //        progressView.layer.cornerRadius = 8
        questionLabel.pushTransitionTop(1)
        questionNumberLabel.pushTransitionLeft(1)
        
    }
    func updateFirebase(){
        let ref = FIRDatabase.database().reference()
        ref.child("Users").child(uid!).child("Dash").child("Question").setValue(questionNumber)
        ref.child("Users").child(uid!).child("Dash").child("Score").setValue(score)
        
        UserDefaults.standard.set(questionNumber, forKey: "Dash QN")
        UserDefaults.standard.set(score, forKey: "Dash Score")
    }
    
    
    func nextQuestion() {
        if questionNumber <= 25 {
            
            updateData()
            
        }
        else{
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
    
    
    //    TODO: Set locations of the views
    func setNavigationBar() {
        
        navBarView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        navBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navBarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navBarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        navBarView.addSubview(backButton)
        navBarView.addSubview(titleLabel)
        
        backButton.leftAnchor.constraint(equalTo: navBarView.leftAnchor).isActive = true
        backButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor, constant: 10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 64).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor, constant: 10).isActive = true
        view.addSubview(navBarView)
    }
    
    func viewSetup() {
        questionLabel.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 10).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        questionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        questionLabel.bottomAnchor.constraint(equalTo: choiceOne.topAnchor, constant: -10).isActive = true 
        
        choiceOne.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        choiceOne.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        choiceOne.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        choiceOne.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        choiceTwo.topAnchor.constraint(equalTo: choiceOne.bottomAnchor, constant: 10).isActive = true
        choiceTwo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        choiceTwo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        choiceTwo.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        choiceThree.topAnchor.constraint(equalTo: choiceTwo.bottomAnchor, constant: 10).isActive = true
        choiceThree.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        choiceThree.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        choiceThree.heightAnchor.constraint(equalToConstant: 75).isActive = true

        
        questionNumberLabel.bottomAnchor.constraint(equalTo: progressUI.topAnchor, constant: -5).isActive = true
        questionNumberLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        questionNumberLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        questionNumberLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        scoreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        scoreLabel.bottomAnchor.constraint(equalTo: progressUI.topAnchor, constant: -5).isActive = true
        scoreLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        scoreLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        progressUI.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        progressUI.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        progressUI.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5).isActive = true
        progressUI.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        previousQuestion.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        previousQuestion.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: 5).isActive = true
        previousQuestion.heightAnchor.constraint(equalToConstant: 40).isActive = true
        previousQuestion.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.addSubview(questionLabel)
        
        view.addSubview(progressUI)
        view.addSubview(questionNumberLabel)
        view.addSubview(scoreLabel)
        //        view.addSubview(progressView)
        view.addSubview(previousQuestion)
        view.addSubview(choiceOne)
        view.addSubview(choiceTwo)
        view.addSubview(choiceThree)
    }
    
    
}

// TODO: Gradient UIImage extension
fileprivate extension UIImage {
    static func gradientImage(with bounds: CGRect,
                              colors: [CGColor],
                              locations: [NSNumber]?) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 1.0,
                                           y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0,
                                         y: 1.0)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
    static func gradientImage2(with bounds: CGRect, colors: [CGColor], locations: [NSNumber]?) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
}
    
    static func gradientImage3(with bounds: CGRect,colors: [CGColor], locations: [NSNumber]?) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 0.0,
                                           y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0,
                                         y: 1.0)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
}
