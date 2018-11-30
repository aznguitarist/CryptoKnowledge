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
        view.setGradientBackground5(oneColor: UIColor.red , twoColor: UIColor.darkGray, threeColor: UIColor.red)
        emailTextFIeld.placeholder = "Enter your email here"
        passwordTextField.placeholder = "Create a password"
        view.addSubview(backButton)
        backButtonPlacement() 
        
    }
    
    var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.clear
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        return button
    }()
    
    @objc func backButtonTapped(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? UIViewController else {
            return
        }
        present(mainRegistrationVC, animated: true, completion: nil)
    }
    
    
    func backButtonPlacement(){
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
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
                        print(err!)
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
