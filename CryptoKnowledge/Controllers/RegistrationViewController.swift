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
        
        guard let email = emailTextFIeld.text, !email.isEmpty else {print("Email is empty"); return}
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("Password is empty"); return}
        let ref = FIRDatabase.database().reference().root
   
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion:
            {(user: FIRUser?, error) in
            if error != nil{
            print(error!)
            } else {
            print("Registration Successful")
                guard let uid = user?.uid else{
                    return}
              let userReference = ref.child("Users").child(uid)
                let values = ["Email": email]
                
                userReference.updateChildValues(values, withCompletionBlock: {(err,ref) in
                    if err != nil{
                        print(err)
                        return
                    }
                 self.goBacktoLogin()
                
                })
                
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return(true)
    }
 
}
