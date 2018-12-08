//
//  MainNavigationController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/19/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationController : UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigateToChoice()
        navigationItem.leftBarButtonItem?.tintColor = Colors.iconContrastYellow
        navigationController?.navigationItem.leftBarButtonItem?.tintColor = Colors.iconContrastYellow
        navigationController?.navigationBar.layer.shadowColor = Colors.iconContrastYellow.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowRadius = 5
        navigationController?.navigationBar.layer.shadowOffset.height = 5
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
       
        navigationController?.navigationBar.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        
    }
    func navigateToChoice () {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "Menu") as? UIViewController else {
            return
        }
        present(mainRegistrationVC, animated: true, completion: nil)
    }
}
