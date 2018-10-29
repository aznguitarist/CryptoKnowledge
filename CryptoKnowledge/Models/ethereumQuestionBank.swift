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
        
        EqBank.append(Questions(quest: "How is Ether created? ", c1: "There is a fixed supply", c2: "10 are created every 10 minutes.", c3: "3 per block", ans: 3))
        
        EqBank.append(Questions(quest: "How many were created initially before the launch? ", c1: "72 Million", c2: "21 Million", c3: "10 Million", ans: 1))
        EqBank.append(Questions(quest: "What are tokens on the Ethereum platform called? ", c1: "ERC-20", c2: "ETH-20", c3: "GAS-20", ans: 1))
        EqBank.append(Questions(quest: "Other crypto-currenices that exist on the Ethereum network are called? ", c1: "Coins", c2: "Tokens", c3: "Dollars", ans: 2))
        EqBank.append(Questions(quest: "One advantage over Bitcoin, Ethereum has is...", c1: "It's ability to handle and create smart contracts.", c2: "It's more decentralized.", c3: "It has more hashing power.", ans: 1))
        EqBank.append(Questions(quest: "Ethereum like Bitcoin is...", c1: "Privately owned", c2: "Open Sourced", c3: "Government owned", ans: 2))
        //10
    }
    
    
}
