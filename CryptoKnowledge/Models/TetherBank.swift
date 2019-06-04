//
//  TetherBank.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 11/30/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

class TetherBank {
    var TetherBank = [Questions]()
    
    init() {
        TetherBank.append(Questions(quest: "What type of token is Tether?", c1: "Privacy Coin", c2: "Dark Coin", c3: "Stable Coin", ans: 3))
        TetherBank.append(Questions(quest: "What is the main purpose of Tether?", c1: "To always be equal to one American dollar", c2: "To provide privacy", c3: "To be equal to one oz of gold", ans: 1))
        TetherBank.append(Questions(quest: "Who created Tether?", c1: "Roger Ver", c2: "Ripple Labs", c3: "Tether Limited", ans: 3))
        TetherBank.append(Questions(quest: "According to Coinmarketcap, how often is tether trade in the winter of 2018?", c1: "Second after bitcoin", c2: "Third after bitcoin", c3: "Fourth after bitcoin", ans: 1))
        TetherBank.append(Questions(quest: "Why is tether considered controversial?", c1: "It's very centralized.", c2: "Unable to provide accurate audits of reserves.", c3: "Government will probably make it illegal to hold.", ans: 2))
        
        TetherBank.append(Questions(quest: "What is a second reason for it's controversy?", c1: "It's alleged role in manipulating bitcoin's price.", c2: "It's unclear relationship with the exchange Bitfinex.", c3: "Both", ans: 3))
        TetherBank.append(Questions(quest: "Which government is investigating Tether's possible market manipulation?", c1: "China", c2: "America", c3: "England", ans: 2))
        TetherBank.append(Questions(quest: "About how many tokens are in circulation as of winter 2018?", c1: "1.85 Billion", c2: "1.95 Billion", c3: "2.05 Billion", ans: 1))
        TetherBank.append(Questions(quest: "When was the white paper published?", c1: "January 2011", c2: "January 2012", c3: "January 2013", ans: 2))
        TetherBank.append(Questions(quest: "What coin did tether try to use as it's inital implementation?", c1: "Doge Coin", c2: "Lite Coin", c3: "Mastercoin", ans: 3))
        
        TetherBank.append(Questions(quest: "Who is one of the famous cofounders of Tether?", c1: "Brock Pearson", c2: "Brock Lesner", c3: "Brock Pierce", ans: 3))
        TetherBank.append(Questions(quest: "When were the first tokens released?", c1: "October 6, 2014", c2: "November 15, 2014",c3: "December 6, 2014", ans: 1))
        TetherBank.append(Questions(quest: "According to their website, what country is Tether incorporated in?", c1: "Hong Kong", c2: "England", c3: "America", ans: 1))
        TetherBank.append(Questions(quest: "How many types of Tether tokens are there?", c1: "1", c2: "3", c3: "4", ans: 3))
        TetherBank.append(Questions(quest: "What two government issued currencies are backed by Tether?", c1: "USD and Yen", c2: "USD and Euro", c3: "USD and the Pound", ans: 2))
       
        TetherBank.append(Questions(quest: "What two blockchains does Tether use to issue their tokens?", c1: "Bitcoin and Ethereum", c2: "Bitcoin and EOS", c3: "Bitcoin and Ripple", ans: 1))
    }
    
}
