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

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.placeholder = "UserName: "
        passwordTextField.placeholder = "Password: "
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
    
}
