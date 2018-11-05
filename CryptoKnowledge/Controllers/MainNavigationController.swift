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
       updateNavBar()
      
        }
        
    func updateNavBar(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back It UP", style: .plain, target: nil, action: nil)
        //            guard let navBar = navigationController?.navigationBar else{
        //                Print("Fatal Error: Navigation bar doesn't exist. ")
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
    }
}
