//
//  QuestionBank .swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/17/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

class QuestionBank{
    var questionBank = [Questions]()
    
    init() {
    
    let qOne = Questions(quest: "Who invented Bitcoin?", c1: "George Washington", c2: "Vitalik Buterin", c3: "Satoshi Nakamoto", ans: 3)
   
    questionBank.append(qOne)
    
    questionBank.append(Questions(quest: "How many bitcoin will be created? ", c1: "1 Million", c2: "11 Million", c3: "21 Million", ans: 3))
    
    questionBank.append(Questions(quest: "How often is a new block mined? ", c1: "10 minutes", c2: "20 minutes", c3: "30 minutes", ans: 1))
    
    questionBank.append(Questions(quest: " Which was the first major exchange that you could buy Bitcoin but started off as a trading card site? ", c1: "Mt. Gox", c2: "CoinBase", c3: "Binance", ans: 1))
    questionBank.append(Questions(quest: "How big is one block? ", c1: "1Gb", c2: "1Mb", c3: "1Tb", ans: 2))
    
    }
}
