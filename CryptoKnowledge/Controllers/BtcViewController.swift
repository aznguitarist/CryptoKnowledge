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
        self.title = "Bitcoin Quiz"
      
        
        let questionNumberSaved = UserDefaults.standard.integer(forKey: "Btc Question Number")
            questionNumber = questionNumberSaved
        let scoreSaved = UserDefaults.standard.integer(forKey: "BTC Score")
            score = scoreSaved
        view.pushTransitionBottom(1)
        questionTextField.pushTransitionLeft(1)
        
        view.addSubview(previousQuestion)
        view.addSubview(progressUI)
        
        viewSetup()
        
        updateData()

            choiceOne.titleLabel?.textAlignment = NSTextAlignment.center
            choiceOne.layer.cornerRadius = 10
            choiceOne.backgroundColor = UIColor.darkGray
            choiceTwo.titleLabel?.textAlignment = NSTextAlignment.center
            choiceTwo.layer.cornerRadius = 10
            choiceTwo.backgroundColor = UIColor.darkGray
            choiceThree.titleLabel?.textAlignment = NSTextAlignment.center
            choiceThree.layer.cornerRadius = 10
            choiceThree.backgroundColor = UIColor.darkGray
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCoinSelectionOut))
           self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let navGradientImage = UIImage.gradientImageNav(with: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: 64), colors: [UIColor.black.cgColor, UIColor.lightGray.cgColor,UIColor.black.cgColor], locations: [0.66, 0.33])
        navigationController?.navigationBar.setBackgroundImage(navGradientImage, for: .default)
        
        
        let gradient = CAGradientLayer()
        gradient.frame = questionTextField.frame
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
        updateData()
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
        questionNumber += 1
        scoreLabel.pushTransitionBottom(1)
        nextQuestion()
        
    }
    
    
    func updateProgress(){
        let num = Double(questionNumber + 1) * 0.04
        progressUI.setProgress(Float(num), animated: true)
        print(num)
        print("Question Number: \(questionNumber)")
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
            
            if score <= 9900 { score += 100 }
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
        questionNumberLabel.text = " Question \(questionNumber + 1)/ 25"
        scoreLabel.text = "Score: \(score)"
        questionTextField.text = nextQuest.question
        choiceOne.setTitle(nextQuest.choice1, for: .normal)
        choiceTwo.setTitle(nextQuest.choice2, for: .normal)
        choiceThree.setTitle(nextQuest.choice3, for: .normal)
        questionTextField.pushTransitionTop(1)
        questionNumberLabel.pushTransitionRight(1)
        updateProgress() 
         updateFirebase()
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
        previousQuestion.heightAnchor.constraint(equalToConstant: 30).isActive = true
        previousQuestion.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.addSubview(previousQuestion)
        
        
        progressUI.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        progressUI.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        progressUI.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        progressUI.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
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
