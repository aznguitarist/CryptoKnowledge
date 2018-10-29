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

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.placeholder = "Email Addres"
        passwordTextField.placeholder = "Password "
        
        self.userNameTextField.delegate = self 
        self.passwordTextField.delegate = self
    }
    
    
    
    @IBAction func registerTapped(_ sender: Any) {
        navigateToRegistration()
        
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        SVProgressHUD.show()
        FIRAuth.auth()?.signIn(withEmail: userNameTextField.text!, password: passwordTextField.text!, completion: {(user, error) in
            if error != nil {
                print(error!)
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
