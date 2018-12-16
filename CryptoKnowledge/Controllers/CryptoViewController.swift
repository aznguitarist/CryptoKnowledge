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

    
    
    let previousQuestion: UIButton = {
        let button = UIButton()
        button.setTitle("< Question", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
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
        
        let questionNumberSaved = UserDefaults.standard.integer(forKey: "questionNumber")
            questionNumber = questionNumberSaved
        let scoreSaved = UserDefaults.standard.integer(forKey: "score")
            score = scoreSaved
        update()
        view.addSubview(progressUI)
        view.addSubview(previousQuestion) 
        
        view.backgroundColor = UIColor.blue 
//       view.setGradientBackground(oneColor: UIColor.black , twoColor: UIColor.blue)
        self.title = "Blockchain"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        
        viewSetup()
      
        view.pushTransitionLeft(1)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
      self.navigationController?.navigationBar.isTranslucent = true
//       self.navigationController?.view.backgroundColor = .clear
//        self.navigationItem.backBarButtonItem?.title = "Try Again"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector (handleCoinSelectionOut))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black 
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowRadius = 5
        navigationController?.navigationBar.layer.shadowOffset.height = 5
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let navGradientImage = UIImage.gradientImageNav(with: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: 64), colors: [UIColor.black.cgColor, UIColor.lightGray.cgColor,UIColor.black.cgColor], locations: [0.66, 0.33])
        navigationController?.navigationBar.setBackgroundImage(navGradientImage, for: .default)
        
        
        let gradient = CAGradientLayer()
        gradient.frame = questionViewer.frame
        gradient.colors = [UIColor.black.cgColor, UIColor.lightGray.cgColor, UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.1)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.cornerRadius = 10
        view.layer.insertSublayer(gradient, at: 1)
        
        let firstGradientImage1 = UIImage.gradientImage1(with: choiceOne.frame, colors: [UIColor.black.cgColor, UIColor.lightGray.cgColor,UIColor.black.cgColor], locations: [0.66, 0.33])
        choiceOne.setBackgroundImage(firstGradientImage1, for: .normal)
        
        
        let secondButtonGradientImage = UIImage.gradientImage2(with:choiceTwo.frame, colors: [UIColor.black.cgColor, UIColor.lightGray.cgColor], locations: [0.1, 0.7])
        choiceTwo.setBackgroundImage(secondButtonGradientImage, for: .normal)
        
        let threeButtonGradientImage = UIImage.gradientImage3(with: choiceTwo.frame, colors: [UIColor.black.cgColor, UIColor.lightGray.cgColor,UIColor.black.cgColor], locations: [0.33, 0.66])
        choiceThree.setBackgroundImage(threeButtonGradientImage, for: .normal)
        
        previousQuestion.setBackgroundImage(firstGradientImage1, for: .normal)
        scoreLabel.textAlignment = .left
        
        
        let gradientImage = UIImage.gradientImage(with: progressUI.frame, colors: [UIColor.black.withAlphaComponent(0.25).cgColor,UIColor.lightGray.cgColor, UIColor.black.withAlphaComponent(0.25).cgColor], locations: [0.0,0.1,0.5])
        progressUI.progressImage = gradientImage!
    }
    
    @objc func previousQ() {
        if questionNumber == 0 {}
        else {questionNumber = questionNumber - 1}
        update()
    }
    
    @objc func handleCoinSelectionOut(){
      performSegue(withIdentifier: "BackToSelection", sender: self)
        view.pushTransitionLeft(5)
        questionViewer.pushTransitionRight(5)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? CryptoChoiceViewController
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
        updateProgress()
        questionNumberView.pushTransitionBottom(1)
    }
    func updateProgress(){
        let num = Double(questionNumber + 1) * 0.04
        progressUI.setProgress(Float(num), animated: true)
        print(num)
        print("Question Number: \(questionNumber)")
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
    
    func viewSetup() {
        
        previousQuestion.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        previousQuestion.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: -10).isActive = true
        previousQuestion.topAnchor.constraint(equalTo: choiceThree.bottomAnchor, constant: 10).isActive = true 
        previousQuestion.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.addSubview(previousQuestion)
        
        
        progressUI.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        progressUI.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        progressUI.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        progressUI.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        view.addSubview(previousQuestion)
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
}

