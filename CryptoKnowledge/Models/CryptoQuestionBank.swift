//
//  CryptoQuestionBank.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/26/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

class CryptoBank {
    var cryptoBank = [Questions]()
    
    init() {
        cryptoBank.append(Questions(quest: "Crypto-currencies are created from what type of technlogy?", c1: "Internet Banking", c2: "Blockchain", c3: "Machine Learning", ans: 2))
        cryptoBank.append(Questions(quest: "What does the acryonym 'ICO' stand for?", c1: "Initial Currency Offering", c2: "Initial Coin Offering", c3: "Independent Currency Offering", ans: 2))
        cryptoBank.append(Questions(quest: "What are the safest types of wallets? ", c1: "Hardware", c2: "Phone", c3: "Online", ans: 1))
        cryptoBank.append(Questions(quest: "What does it mean if you store your crypto in a cold wallet?", c1: "You put it in the fridge.", c2: "You put it in wallet that's diconnected to the internet", c3: "You put your crypto in a wallet that is connected to the internet", ans: 2))
        cryptoBank.append(Questions(quest: "Exodus is an example of what type of wallet?", c1: "Paper Wallet", c2: "Hot wallet", c3: "Cold Wallet", ans: 2))
        cryptoBank.append(Questions(quest: "What does decentralized mean?", c1: "It's not controlled by the government.", c2: "Its not controlled by a company", c3: "Both", ans: 3)) 
        
    }
}
