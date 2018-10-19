//
//  ViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/17/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var bitcoinButton: UIButton!
    @IBOutlet weak var ethereumButton: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
    bitcoinButton.layer.cornerRadius = 5
    bitcoinButton.layer.borderWidth = 1
    bitcoinButton.layer.borderColor = UIColor.black.cgColor
//    bitcoinButton.layer.backgroundColor = UIColor.gray.cgColor
        
    ethereumButton.layer.cornerRadius = 10
    ethereumButton.layer.borderWidth = 1
    ethereumButton.layer.borderColor = UIColor.black.cgColor
//    ethereumButton.layer.backgroundColor = UIColor.gray.cgColor
        
    
        
    }


}

