//
//  CoinList.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/29/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

class Coins {
    var image : UIImage
    var name : String
    var progress: String
    var vcControl: String
    
    
    init(image: UIImage, name: String, progress: String, controller: String) {
        self.image = image
        self.name = name
        self.progress = progress
        self.vcControl = controller 
        
    }
}
