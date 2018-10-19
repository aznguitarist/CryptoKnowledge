//
//  ethereumQuestionBank.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/18/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

class EQBank {
    var EqBank = [Questions]()
    
    init(){
        
        EqBank.append(Questions(quest: "Who was the creater of Ethereum?", c1: "Vitalik Buterin", c2: "Satoshi Nakamoto", c3: "Justin Sun", ans: 1))
        
        EqBank.append(Questions(quest: "What is the name of the crypto currency that is used on the Ethereum platform? ", c1: "Ethos", c2: "Ether", c3: "Gas", ans: 2))
        EqBank.append(Questions(quest: "How often is a new block created on the Ethereum blockchain? ", c1: "14-15 seconds", c2: "14-15 minutes", c3: "14-15 nanoseconds", ans: 1))
        EqBank.append(Questions(quest: "When was Ethereum's white paper initially pubished? ", c1: "2010", c2: "2012", c3: "2013", ans: 3))
    }
    
    
}
