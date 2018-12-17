//
//  User.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 11/6/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class User: NSObject{
    var email: String?
    var cryptoquizQN: Int?
    var cryptoquizScore: Int?
    
    init(email: String = "none", cryptoquizQN: Int = 0 , cryptoquizScore: Int = 0) {
       self.email = email
        self.cryptoquizQN = cryptoquizQN
        self.cryptoquizScore = cryptoquizScore
    }
    
    func firebaseStart()  {
       let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("Users").child(uid!).child("Cryptoquiz").observeSingleEvent(of: .value) { (snap) in
            if let val = snap.value as? [String: Any]{
                let number = val["Question Number"] as? Int
                self.cryptoquizQN = number 
                print(self.cryptoquizQN)
            }
        }
    }
    
}
