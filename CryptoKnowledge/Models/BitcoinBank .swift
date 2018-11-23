//
//  QuestionBank .swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/17/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

class BitcoinBank{
    var questionBank = [Questions]()
    
    init() {
    
    let qOne = Questions(quest: "Who invented Bitcoin?", c1: "George Washington", c2: "Vitalik Buterin", c3: "Satoshi Nakamoto", ans: 3)
   
    questionBank.append(qOne)
    
    questionBank.append(Questions(quest: "How many bitcoin will be created? ", c1: "1 Million", c2: "11 Million", c3: "21 Million", ans: 3))
    
    questionBank.append(Questions(quest: "How often is a new block mined? ", c1: "10 minutes", c2: "20 minutes", c3: "30 minutes", ans: 1))
    
    questionBank.append(Questions(quest: " Which was the first major exchange that you could buy Bitcoin but started off as a trading card site? ", c1: "Mt. Gox", c2: "CoinBase", c3: "Binance", ans: 1))
    questionBank.append(Questions(quest: "How big is one block? ", c1: "1Gb", c2: "1Mb", c3: "1Tb", ans: 2))
    questionBank.append(Questions(quest: "How do you store your Bitcoin", c1: "Wallets", c2: "Purse", c3: "Bank", ans: 1))
    questionBank.append(Questions(quest: "How often should you create a new address when doing a transaction? ", c1: "Never", c2: "Everytime you do a transaction", c3: "When creating a new account with a new person or company.", ans: 2))
    questionBank.append(Questions(quest: "How is new bitcoin created? ", c1: "Computers solving a mathmatical algorithms.", c2: "Miningit in a mine.", c3: "Individual wallets on the network are rewarded.", ans: 1))
    questionBank.append(Questions(quest: "How many Bitcoins were rewarded in the first blocks? ", c1: "20", c2: "50", c3: "100", ans: 2))
    questionBank.append(Questions(quest: "How often is the mining reward split in half? ", c1: "Every 4 years", c2: "Every 510,000 block", c3: "Every 100,000 blocks", ans: 2))
    questionBank.append(Questions(quest: "Why can Bitcoin be considered a commodity like gold?", c1: "Has a finite amount of 21 million", c2: "It's price correlates with gold's price", c3: "It's physical properties are similar to gold.", ans: 1))
    questionBank.append(Questions(quest: "What's the safest way to store your bitcoin?", c1: "Online wallets", c2: "Phone wallets", c3: "Hardware Wallets", ans: 3))
    questionBank.append(Questions(quest: "Who get's the fees?", c1: "The miner(s) that mines the new block.", c2: "The receiver of the transaction", c3: "Satoshi Nakamoto", ans: 1))
    questionBank.append(Questions(quest: "What is a double spend?", c1: "When a sender tries to spend the same bitcoin.", c2: "When the receiver accidently receives double what they are suposed to.", c3: "When the sender does two transactions at the same time", ans: 1))
     questionBank.append(Questions(quest: "Why is it important to wait for a confirmation? ", c1: "Prevent a double spend", c2: "Make sure you can reverse the transaction later.", c3: "You can't check the transaction until you get one.", ans: 1))
    
    //15 questions
    
    }
}
