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
    
    var exchangeTransfer = ["ExchangesViewController"]
 
    @IBOutlet weak var quizesButton: UIButton!
    @IBOutlet weak var walletsButton: UIButton!
    @IBOutlet weak var exchanges: UIButton!
    @IBOutlet weak var exchangesTwoButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Menu"
        view.backgroundColor = Colors.iconDarkBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.iconContrastYellow]
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.barTintColor = UIColor.black.withAlphaComponent(0.1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector (backToLogIn))
        navigationItem.leftBarButtonItem?.tintColor = Colors.iconContrastYellow


        quizesButton.setTitle("Quizes", for: .normal)
        quizesButton.setTitleColor(Colors.iconContrastYellow, for: .normal)

        walletsButton.setTitleColor(Colors.iconContrastYellow, for: .normal)
        walletsButton.setTitle("Wallets", for: .normal)
       
        exchanges.setTitle("Exchanges", for: .normal)
        exchanges.setTitleColor(Colors.iconContrastYellow, for: .normal)
        exchanges.titleLabel?.adjustsFontSizeToFitWidth = true
//        walletsButton.layer.cornerRadius = walletsButton.bounds.size.height/2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let navGradientImage = UIImage.gradientImageNav(with: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: 64), colors: [UIColor.black.cgColor, UIColor.lightGray.cgColor,UIColor.black.cgColor], locations: [0.66, 0.33])
        navigationController?.navigationBar.setBackgroundImage(navGradientImage, for: .default)
        
        
        let gradientOne = UIImage.gradientImage(with: quizesButton.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor, UIColor.darkGray.cgColor], locations: [0.1, 0.5])
        quizesButton.setBackgroundImage(gradientOne, for: .normal)
        quizesButton.layer.cornerRadius = 20
        
        let gradientTwo = UIImage.gradientImage2(with: walletsButton.frame, colors: [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor, UIColor.darkGray.cgColor], locations: [0.2,0.6,0.8])
        walletsButton.setBackgroundImage(gradientTwo, for: .normal)
        walletsButton.layer.cornerRadius = 20
        
        exchanges.setBackgroundImage(gradientOne, for: .normal)
        exchanges.layer.cornerRadius = 20
        exchanges.titleLabel?.adjustsFontSizeToFitWidth = true
        
        exchangesTwoButton.setBackgroundImage(gradientOne, for: .normal)
        exchangesTwoButton.layer.cornerRadius = 20
        exchangesTwoButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
//        exchanges.addTarget(self, action: #selector(exchangesTapped), for: .touchUpInside)
        
    }
  
    @IBAction func quizzesTapped(_ sender: Any) {
        quizesButton.pulsate()
       navigateToQuizes()
    }
    
    @IBAction func walletsTapped(_ sender: AnyObject) {
        walletsButton.pulsate()
       
        if sender.tag == 2 { DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           self.performSegue(withIdentifier: "walletsSegue", sender: self)
       
            }
        }
    }
    @IBAction func exchangesTap(_ sender: Any) {
        exchanges.flash()
        let exchangesVC = ExchangesViewController()
        present(exchangesVC,animated: true, completion: nil)
        print()
    }

    @IBAction func exchangesTwoTapped(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "toMarket", sender: self)
      
//        let exchangesVc = MarketViewController()
//        present(exchangesVc, animated:  true, completion:  nil)
//        print("Market")
    }
    
    
    @objc func backToLogIn() { 
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
            present(mainRegistrationVC, animated: true, completion: nil)
        }
    
    
func navigateToQuizes() {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
       let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController")
        present(mainRegistrationVC, animated: true, completion: nil)}

    func navigateToWallets() {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "wallets")
        present(mainRegistrationVC, animated: true, completion: nil)
    }

}






// TODO: Gradient UIImage extension
fileprivate extension UIImage {
    
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
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
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
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        
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
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
}
