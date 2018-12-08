//
//  File.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 12/3/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVFoundation

class EOSViewController: UIViewController, AVAudioPlayerDelegate {
    
    let eosQuestions = EOSBank()
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
        navBar.backgroundColor = UIColor.darkGray
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.layer.masksToBounds = true
//        navBar.gradientEos(oneColor: UIColor.lightGray, twoColor: UIColor.blue)
        return navBar
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
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
        label.text = "EOS"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        return label
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = "Question"
        label.textColor = UIColor.black
        label.textAlignment = .center
//        label.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        label.font = label.font.withSize(30)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 5
        return label
    }()
    //    TODO: Choices View
    let choiceOne: UIButton = {
        let button = UIButton()
        button.setTitle("One", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.titleLabel?.numberOfLines = 3
        button.tag = 1
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
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
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.titleLabel?.numberOfLines = 3
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(answerTwo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tag = 2
        
        return button
    }()
    let choiceThree: UIButton = {
        let button = UIButton()
        button.setTitle("Three", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.titleLabel?.numberOfLines = 3
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
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
        label.textColor = UIColor.white
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
        label.textColor = UIColor.white
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
        progress.tintColor = UIColor.black.withAlphaComponent(0.5)
        progress.layer.borderColor = UIColor.gray.cgColor
        progress.layer.borderWidth = 2
        progress.layer.cornerRadius = 5
        return progress
    }()
    
    
//    let progressView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.masksToBounds = true
//        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
//
//        return view
//    }()
    
  
    // TODO: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        score = UserDefaults.standard.integer(forKey: "EOS Score")
        questionNumber = UserDefaults.standard.integer(forKey: "EOS QN")
        
//        self.perform(#selector(updateProgress), with: nil, afterDelay: 0.01)
        
//        view.setGradientBackgroundEOS(oneColor: UIColor.black, twoColor: UIColor.white)
        view.backgroundColor = UIColor.black
         view.addSubview(navBarView)
        
        print("Subviews: \(view.subviews.count)")
//        view.addSubview(progressView)
        view.addSubview(questionLabel)
        view.addSubview(choiceOne)
        view.addSubview(choiceTwo)
        view.addSubview(choiceThree)
        
    
        view.addSubview(previousQuestion)
        view.addSubview(scoreLabel)
        view.addSubview(questionNumberLabel)
        view.addSubview(progressUI)
        print("Subviews: \(view.subviews.count)")
        
        
        updateData()
        setNavigationBar()
        viewSetup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    
        navBarView.gradientEos(oneColor: UIColor.darkGray, twoColor: UIColor.lightGray)
//        progressUI.setGradientBackground4(oneColor: UIColor.black, twoColor: UIColor.white, threeColor: UIColor.black)
        let gradientImage = UIImage.gradientImage(with: progressUI.frame,
                                                  colors: [UIColor.black.withAlphaComponent(0.8).cgColor, UIColor.lightGray.cgColor],
                                                  locations: nil)
    
        progressUI.progressImage = gradientImage!
        
        let gradient = CAGradientLayer()
        gradient.frame = questionLabel.frame
        gradient.colors = [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.1)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.cornerRadius = 10
        view.layer.insertSublayer(gradient, at: 1)
        
        let firstGradientImage1 = UIImage.gradientImage1(with: choiceTwo.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor,UIColor.darkGray.cgColor], locations: [0.66, 0.33])
        choiceOne.setBackgroundImage(firstGradientImage1, for: .normal)
        
        
        let secondButtonGradientImage = UIImage.gradientImage2(with:choiceTwo.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor], locations: [0.1, 0.8])
        choiceTwo.setBackgroundImage(secondButtonGradientImage, for: .normal)
        
        let threeButtonGradientImage = UIImage.gradientImage3(with: choiceTwo.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor,UIColor.darkGray.cgColor], locations: [0.33, 0.66])
        choiceThree.setBackgroundImage(threeButtonGradientImage, for: .normal)
        
        previousQuestion.setBackgroundImage(firstGradientImage1, for: .normal)
//
//        updateData()
//        setNavigationBar()
//        viewSetup()
//
        
    }
    
    // TODO: object C
    
    @objc func previousQ() {
        if questionNumber == 0 {}
        else {questionNumber = questionNumber - 1}
        updateData()
    }
    
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
    
    @objc func back() { // remove @objc for Swift 3
        //        let coinChoice = CryptoChoiceViewController()
        //        present(coinChoice, animated: true, completion: nil)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as? UIViewController else {
            return
        }
        present(mainRegistrationVC, animated: true, completion: nil)
    }

    
    
    func checkAnswers() {
        if pickedAnswer == eosQuestions.EOSBank[questionNumber].answer{
           
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
    
    func updateData(){
        updateFirebase()
        updateProgress()
        let nextQuest = eosQuestions.EOSBank[questionNumber]
        scoreLabel.text = "Score: \(score)"
        questionLabel.text = nextQuest.question
        choiceOne.setTitle(nextQuest.choice1, for: .normal)
        choiceTwo.setTitle(nextQuest.choice2, for: .normal)
        choiceThree.setTitle(nextQuest.choice3, for: .normal)
        questionNumberLabel.text = "Question: \(questionNumber + 1)/25"
//        progressView.frame.size.width = (view.frame.size.width/25) * CGFloat(questionNumber + 1)
//        progressView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.70)
//        progressView.layer.cornerRadius = 8
        questionLabel.pushTransitionTop(1)
        questionNumberLabel.pushTransitionLeft(1)
      
    }
    func updateFirebase(){
        let ref = FIRDatabase.database().reference()
        ref.child("Users").child(uid!).child("EOS").child("Question").setValue(questionNumber)
        ref.child("Users").child(uid!).child("EOS").child("Score").setValue(score)
        
        UserDefaults.standard.set(questionNumber, forKey: "EOS QN")
        UserDefaults.standard.set(score, forKey: "EOS Score")
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

    
    //    TODO: Set locations of the views
    func setNavigationBar() {
        
            navBarView.heightAnchor.constraint(equalToConstant: 64).isActive = true
            navBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            navBarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            navBarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        navBarView.addSubview(backButton)
        navBarView.addSubview(titleLabel)
        
        backButton.leftAnchor.constraint(equalTo: navBarView.leftAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: navBarView.topAnchor, constant: 10).isActive = true
        backButton.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 64).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 10).isActive = true
        view.addSubview(navBarView)
    }
    
    func viewSetup() {
        questionLabel.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 10).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        questionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        choiceOne.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 15).isActive = true
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
        
        //        progressView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //        progressView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //        progressView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //        progressView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //        progressView.frame.size.width = (view.frame.size.width/25) * CGFloat(questionNumber + 1)
        
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
        view.addSubview(choiceThree)    }
    
 
}


fileprivate extension UIImage {
    static func gradientImage(with bounds: CGRect,
                              colors: [CGColor],
                              locations: [NSNumber]?) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 0.0,
                                           y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0,
                                         y: 0.5)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
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
    
    static func gradientImage2(with bounds: CGRect,
                               colors: [CGColor],
                               locations: [NSNumber]?) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 0.0,
                                           y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0,
                                         y: 0.5)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
    static func gradientImage3(with bounds: CGRect,
                               colors: [CGColor],
                               locations: [NSNumber]?) -> UIImage? {
        
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
