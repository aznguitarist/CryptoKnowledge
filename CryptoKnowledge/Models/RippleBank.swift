//
//  RippleBank.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 11/13/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation

class RippleBank{
    var questionBank = [Questions]()
    
    init() {
        questionBank.append(Questions(quest: "How many Ripple tokens are in circulation? ", c1: "Around 4,000,000", c2: "Around 40,000,000", c3: "Around 40,000,000,000", ans: 3))
        questionBank.append(Questions(quest: "What will the total number of ripple be?", c1: "100,000,000", c2: "1,000,000,000", c3: "100,000,000,000", ans: 3))
        questionBank.append(Questions(quest: "What is the ticker symbol?", c1: "XRP", c2: "RIP", c3: "RPL", ans: 1))
        questionBank.append(Questions(quest: "Which country is Ripple based in?", c1: "Japan", c2: "USA", c3: "Germany", ans: 2))
        questionBank.append(Questions(quest: "When was Ripple initally released?", c1: "2012", c2: "2013", c3: "2014", ans: 1))
        questionBank.append(Questions(quest: "What is the smallest unit of ripple called?", c1: "Rip", c2: "Drop", c3: "Puddle", ans: 2))
        questionBank.append(Questions(quest: "How far is one ripple divisable by?", c1: "3 decimal places", c2: "5 decimal places", c3: "6 decimal places", ans: 3))
        questionBank.append(Questions(quest: "According to the developers, why are there fees?", c1: "To make the holders more money.", c2: "To pay taxes", c3: "Keep the network from flooding", ans: 3))
        questionBank.append(Questions(quest: "Who started the creation of Ripple?", c1: "Chris Larsen and Jed McCaleb ", c2: "Justin Sun and Roger Ver", c3: "Satoshi Nakamoto", ans: 1))
        questionBank.append(Questions(quest: "What company started developing the Ripple protocol", c1: "Ripple Labs", c2: "Open Coin", c3: "Coinbase", ans: 2))
        questionBank.append(Questions(quest: "Ripple is what kind of company?", c1: "It's not a company", c2: "It's a privately funded company", c3: "It's an LLC", ans: 2))
        questionBank.append(Questions(quest: "Why did Ripple have to pay a $700,000 fine to FinCEN?", c1: "Embezzelment", c2: "Not registering as a money service business", c3: "Hiding taxes", ans: 2))
    }
    //12
}
