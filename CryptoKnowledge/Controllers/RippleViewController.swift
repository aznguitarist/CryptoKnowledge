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

    let previousQuestion: UIButton = {
        let button = UIButton()
        button.setTitle("< Question", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
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
        view.setGradientBackground(oneColor: UIColor.darkGray , twoColor: UIColor.blue)
        self.title = "Ripple Quiz"
        view.pushTransitionLeft(1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleSegueToCryptoChoice))
      navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowRadius = 5
        navigationController?.navigationBar.layer.shadowOffset.height = 5
        
        view.addSubview(progressUI)
        view.addSubview(previousQuestion) 
        viewSetup()
//        view.addSubview(navBar)
//        setNavigationBar()
        updateData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let navGradientImage = UIImage.gradientImageNav(with: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: 64), colors: [UIColor.black.cgColor, UIColor.lightGray.cgColor,UIColor.black.cgColor], locations: [0.66, 0.33])
        navigationController?.navigationBar.setBackgroundImage(navGradientImage, for: .default)
        
        
        let gradient = CAGradientLayer()
        gradient.frame = questionLabel.frame
        gradient.colors = [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.1)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.cornerRadius = 10
        view.layer.insertSublayer(gradient, at: 1)
        
        let firstGradientImage1 = UIImage.gradientImage1(with: choiceOneButton.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor,UIColor.darkGray.cgColor], locations: [0.66, 0.33])
        choiceOneButton.setBackgroundImage(firstGradientImage1, for: .normal)
         choiceOneButton.titleLabel?.textAlignment = NSTextAlignment.center
        
        let secondButtonGradientImage = UIImage.gradientImage2(with:choiceTwoButton.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor], locations: [0.1, 0.7])
        choiceTwoButton.setBackgroundImage(secondButtonGradientImage, for: .normal)
        choiceThreeButton.titleLabel?.textAlignment = NSTextAlignment.center
        let threeButtonGradientImage = UIImage.gradientImage3(with: choiceThreeButton.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor,UIColor.darkGray.cgColor], locations: [0.33, 0.66])
        choiceThreeButton.setBackgroundImage(threeButtonGradientImage, for: .normal)
        choiceThreeButton.titleLabel?.textAlignment = NSTextAlignment.center
        previousQuestion.setBackgroundImage(firstGradientImage1, for: .normal)
        scoreLabel.textAlignment = .left
        
//        
//        let gradientImage = UIImage.gradientImage(with: progressUI.frame, colors: [UIColor.black.withAlphaComponent(0.25).cgColor,UIColor.lightGray.cgColor, UIColor.black.withAlphaComponent(0.25).cgColor], locations: [0.0,0.1,0.5])
//        progressUI.progressImage = gradientImage!
    }
    
    
    @objc func previousQ() {
        if questionNumber == 0 {}
        else {questionNumber = questionNumber - 1}
        updateData()
    }
    
    @objc func handleSegueToCryptoChoice(){
        performSegue(withIdentifier: "rippleBackToCoinChoice", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? CryptoChoiceViewController
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
    func updateProgress(){
        let num = Double(questionNumber + 1) * 0.04
        progressUI.setProgress(Float(num), animated: true)
        print(num)
        print("Question Number: \(questionNumber)")
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
            scoreLabel.pushTransitionBottom(1)
        }
        else{
            do{
            let avPlayer2 = Bundle.main.url(forResource: "basswronganswer", withExtension: "wav")
            wrongNoise = try AVAudioPlayer(contentsOf: avPlayer2!)
        }catch {print("Error with wrong audio")}
        wrongNoise.play()
            
        }
    }
    
    
    func updateData(){
      let nextQuestion = rippleQuestionList.questionBank[questionNumber]
        scoreLabel.text = "Score: \(score)"
        questionLabel.text = nextQuestion.question
        choiceOneButton.setTitle(nextQuestion.choice1, for: .normal)
        choiceTwoButton.setTitle(nextQuestion.choice2, for: .normal)
        choiceThreeButton.setTitle(nextQuestion.choice3, for: .normal)
        questionNumberLabel.text = "Question: \(questionNumber + 1)/25"
        questionLabel.pushTransitionTop(1)
        questionNumberLabel.pushTransitionRight(1)
       
        updateProgress()
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
        if questionNumber <= 24 {
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
    
        
        progressUI.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        progressUI.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        progressUI.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        progressUI.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        view.addSubview(previousQuestion)
        view.addSubview(progressUI)
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

