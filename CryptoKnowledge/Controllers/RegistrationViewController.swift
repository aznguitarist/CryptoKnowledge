//
//  RegistrationViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/22/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegistrationViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextFIeld: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextFIeld.placeholder = "Enter your email here"
        passwordTextField.placeholder = "Create a password"
        
    }
    
    
    
    
    @IBAction func registrationTapped(_ sender: AnyObject) {
        
        FIRAuth.auth()?.createUser(withEmail: emailTextFIeld.text!, password: passwordTextField.text!, completion:
            {(user, error) in
            if error != nil{
            print(error!)
            print("There was an error")
                
                
            } else {
            print("Registration Successful")
            self.goBacktoLogin()
                }
            })

        }
        
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        
    }
    
    private func goBacktoLogin () {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? UIViewController else {
            return
        }
        present(mainRegistrationVC, animated: true, completion: nil)
    }
 
}
