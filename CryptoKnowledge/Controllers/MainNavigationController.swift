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
        //            guard let navBar = navigationController?.navigationBar else{
        //                Print("Fatal Error: Navigation bar doesn't exist. ")
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
    }
}
