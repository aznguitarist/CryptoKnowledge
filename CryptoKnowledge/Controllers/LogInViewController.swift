//
//  LogInViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/19/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD
import AVFoundation


class LoginViewController: UIViewController, UITextFieldDelegate, AVAudioPlayerDelegate {
    
    var player = AVAudioPlayer()
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do {
            let audioPlayer = Bundle.main.url(forResource: "Dee_Yan-Key_-_06_-_Sweet_Silence", withExtension: "mp3")
            player = try AVAudioPlayer(contentsOf: audioPlayer!)
        } catch {
            print("Error")
        }
        view.setGradientBackground(oneColor: UIColor.purple, twoColor: UIColor.black)
        player.play()
        
        userNameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        
        self.userNameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        let userDefaultDict = UserDefaults.standard.dictionaryRepresentation()
        
        print(userDefaultDict)
   
        for (key, value) in userDefaultDict {
            print("\(key) = \(value) \n")
        }
        
        
        
    }
    
    
    
    @IBAction func registerTapped(_ sender: Any) {
        navigateToRegistration()
        
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        SVProgressHUD.show()
        guard let email = userNameTextField.text, !email.isEmpty else { print("Email is empty"); return }
        guard let password = passwordTextField.text, !password.isEmpty else { print("Password is empty"); return}

        FIRAuth.auth()?.signIn(withEmail: userNameTextField.text!, password: passwordTextField.text!, completion: {(user, error) in
            if error != nil {
                print(error!)
                SVProgressHUD.dismiss()
                let alert = UIAlertView(title: "Invalid", message: "Try again", delegate: self, cancelButtonTitle: "Ok")
                alert.show()

            }else{
                SVProgressHUD.dismiss()
                print("Login Successfull")
                self.navigateToChoice()
            }
        })
        
    }
    
    private func navigateToChoice () {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController else {
            return
        }
        present(mainNavigationVC, animated: true, completion: nil)
    }

    
    private func navigateToRegistration () {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "Registration") as? UIViewController else {
            return
        }
        present(mainRegistrationVC, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return(true)
    }
    
    
}
