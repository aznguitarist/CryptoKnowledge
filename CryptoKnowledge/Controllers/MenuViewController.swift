//
//  MenuViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 11/29/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit


class MenuViewController: UIViewController{
    
 
    @IBOutlet weak var quizesButton: UIButton!
    @IBOutlet weak var walletsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
  
        view.setGradientBack(oneColor: Colors.iconDarkBlue, twoColor: Colors.blackPurple)
//        view.setGradientBackground5(oneColor: UIColor.gray, twoColor: UIColor.blue, threeColor: UIColor.gray)
        title = "Menu"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector (backToLogIn))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.purple
       navigationController?.navigationBar.barTintColor = UIColor.black.withAlphaComponent(0)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.layer.shadowColor = UIColor.purple.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.3
        navigationController?.navigationBar.layer.shadowRadius = 5
        navigationController?.navigationBar.layer.shadowOffset.height = 10
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        quizesButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        quizesButton.setTitle("Quizes", for: .normal)
        quizesButton.layer.cornerRadius = quizesButton.bounds.size.height/2

        walletsButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        walletsButton.setTitle("Wallets", for: .normal)
        walletsButton.layer.cornerRadius = walletsButton.bounds.size.height/2
        
    }
  
   
    @IBAction func quizzesTapped(_ sender: Any) {
        quizesButton.pulsate()
        quizesButton.shake()
        
       navigateToQuizes()
       
    }
    
    @IBAction func walletsTapped(_ sender: Any) {
        walletsButton.shake()
        navigateToWallets()
    }
    

    
    @objc func backToLogIn() { 
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? UIViewController else {
                return
            }
            present(mainRegistrationVC, animated: true, completion: nil)
        }
    
    
func navigateToQuizes() {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as? UIViewController else {
            return
        }
        present(mainRegistrationVC, animated: true, completion: nil)
    }

    func navigateToWallets() {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "") as? UIViewController else {
            return
        }
        present(mainRegistrationVC, animated: true, completion: nil)
    }

}




//
//    var quizes: UIButton =
//    {
//        let button = GradientButton()
//        let rect = CGRect(x: 20, y: 20, width: 200, height: 100)
//        let button = GradientButton(leftColor: UIColor.red, rightColor: UIColor.cyan, image: UIImage(named: "1")!)
//        button.frame = rect
//        self.view.addSubview(button)
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.masksToBounds = true
//        button.setTitle("Quizes", for: .normal)
//        button.setTitleColor(Colors.moneroOrange, for: .normal)
//        button.layer.cornerRadius = 100
//        button.addTarget(self, action: #selector(navigateToQuizes), for: .touchUpInside)
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = button.bounds
//        gradientLayer.colors = [UIColor.green, UIColor.purple]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//
//
//        return button
//    }()
//
//
//
//    var wallets: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.masksToBounds = true
//        button.setTitle("Wallets", for: .normal)
//        button.setTitleColor(Colors.iconContrastYellow, for: .normal)
//        button.backgroundColor = UIColor.black
//        button.layer.cornerRadius = 100
//        return button
//    }()
//
//    var exchanges: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.masksToBounds = true
//        button.setTitle("Exchanges", for: .normal)
//        button.setTitleColor(Colors.iconContrastYellow, for: .normal)
//        button.backgroundColor = UIColor.black
//        button.layer.cornerRadius = 10
//        return button
//    }()
//


//    func quizPosition(){
//        quizes.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        quizes.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        quizes.topAnchor.constraint(equalTo: view.topAnchor, constant: 54).isActive = true
//        quizes.heightAnchor.constraint(equalToConstant: (view.frame.size.height - 44)/2).isActive = true
//    }
//
//
//    func walletPosition(){
//        wallets.topAnchor.constraint(equalTo: quizes.bottomAnchor, constant: 5).isActive = true
//        wallets.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
//        wallets.widthAnchor.constraint(equalToConstant: view.frame.size.width ).isActive = true
////        wallets.heightAnchor.constraint(equalToConstant: 150).isActive = true
//    }
//
//    func exchangesPosition(){
//        exchanges.topAnchor.constraint(equalTo: quizes.bottomAnchor, constant: 10).isActive = true
//        exchanges.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        exchanges.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        exchanges.heightAnchor.constraint(equalToConstant: 150).isActive = true
//    }
    
//  
//    @objc func navigateToQuizes() {
//        
//
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        
//        guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as? UIViewController else {
//            return
//        }
//        present(mainRegistrationVC, animated: true, completion: nil)
//    }
//}



