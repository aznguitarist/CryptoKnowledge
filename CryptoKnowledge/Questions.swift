//
//  Questions.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/17/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation

class Questions {
    var question : String
    var choice1 : String
    var choice2 : String
    var choice3 : String
    var answer: Int
    
    init(quest : String, c1: String, c2 : String, c3 : String, ans : Int ) {
        question = quest
        choice1 = c1
        choice2 = c2
        choice3 = c3
        answer = ans
        
    }
    
}
