//
//  FirstMainNavigationController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 11/30/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

class FirstMainNavigationController : UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigateToChoice()
        
    }
    
   
    
    func navigateToChoice () {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "Menu") as? UIViewController else {
            return
        }
        present(mainRegistrationVC, animated: true, completion: nil)
    }
}
