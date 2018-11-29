//
//  ethereumQuestionBank.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/18/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit

class EQBank {
    var EqBank = [Questions]()
    
    init(){
        
        EqBank.append(Questions(quest: "Who was the creater of Ethereum?", c1: "Vitalik Buterin", c2: "Satoshi Nakamoto", c3: "Justin Sun", ans: 1))
        
            EqBank.append(Questions(quest: "How was the name chosen?", c1: "Research done on elements and Sci-fi", c2: "Burerin's favorite band", c3: "The suggestion of a friend", ans: 1))
        
        EqBank.append(Questions(quest: "What is the name of the crypto currency that is used on the Ethereum platform? ", c1: "Ethos", c2: "Ether", c3: "Gas", ans: 2))
        EqBank.append(Questions(quest: "How often is a new block created on the Ethereum blockchain? ", c1: "14-15 seconds", c2: "14-15 minutes", c3: "14-15 nanoseconds", ans: 1))
        EqBank.append(Questions(quest: "When was Ethereum's white paper initially pubished? ", c1: "2010", c2: "2012", c3: "2013", ans: 3))
        EqBank.append(Questions(quest: "When was Ethereum released?", c1: "2012", c2: "2014", c3: "2015", ans: 3))
        
        EqBank.append(Questions(quest: "How is Ether created? ", c1: "There is a fixed supply", c2: "10 are created every 10 minutes.", c3: "3 per block", ans: 3))
        EqBank.append(Questions(quest: "What's a main reason needed for Ether?", c1: "To run DApps", c2: "To buy nefarious goods", c3: "To stop spamming of the network", ans: 1))
        EqBank.append(Questions(quest: "How many were created initially before the launch? ", c1: "72 Million", c2: "21 Million", c3: "10 Million", ans: 1))
        EqBank.append(Questions(quest: "What are tokens on the Ethereum platform called? ", c1: "ERC-20", c2: "ETH-20", c3: "GAS-20", ans: 1))
        EqBank.append(Questions(quest: "Other crypto-currenices that exist on the Ethereum network are called? ", c1: "Coins", c2: "Tokens", c3: "Dollars", ans: 2))
      
        EqBank.append(Questions(quest: "One advantage over Bitcoin, Ethereum has is...", c1: "It's ability to handle and create smart contracts.", c2: "It's more decentralized.", c3: "It has more hashing power.", ans: 1))
        EqBank.append(Questions(quest: "Ethereum like Bitcoin is...", c1: "Privately owned", c2: "Open Sourced", c3: "Government owned", ans: 2))
        EqBank.append(Questions(quest: "What are DApps?", c1: "Decentralized Applications", c2: "Digitized Applications", c3: "Divided Applications", ans: 1))
        EqBank.append(Questions(quest: "What are two benefits of DApps?", c1: "No downtime and are free", c2: "No fraud and free of viruses", c3: "No fraud or downtime", ans: 3))
        EqBank.append(Questions(quest: "When was Ethereum Classic created?", c1: "2016", c2: "2017", c3: "2018", ans: 1))
     
        EqBank.append(Questions(quest: "Why was Ethereum Classic created?", c1: "Developers didn't agree how to scale Ethereum.", c2: "To reverse a theft that happend", c3: "To give it's holders more Ether.", ans: 2))
        EqBank.append(Questions(quest: "All addresses start with what characters?", c1: "0x", c2: "RGB", c3: "01", ans: 1))
        EqBank.append(Questions(quest: "How does Ethereum try to reduce the advantage of ASIC's mining?", c1: "Uses only CPU", c2: "Uses the Ethash algorithm", c3: "Uses SHA256 algorithm", ans: 2))
        EqBank.append(Questions(quest: "How do transaction fees differ?", c1: "Transaction Size", c2: "Computational complexity, bandwidth use, and storage needs", c3: "Amount sent", ans: 2))
        
        EqBank.append(Questions(quest: "What are transaction fees refered to as?", c1: "Cost", c2: "Liabilities", c3: "Gas", ans: 3))
        EqBank.append(Questions(quest: "What are Gas units measured in?", c1: "Gwei", c2: "Ounces", c3: "Fuel", ans: 1))
        EqBank.append(Questions(quest: "As of June 2018, What was the estimated supply of Ether?",c1: "100,000,000", c2: "200,000,000", c3: "300,000,000", ans: 1))
        EqBank.append(Questions(quest: "As of now, what is the cap set at on the amount of Ether that will be created", c1: "1 Billion", c2: "100 Billion", c3: "No Cap", ans: 3))
        EqBank.append(Questions(quest: "What are Ethereum's smart contracts based on?", c1: "C+", c2: "Swift", c3: "Different programming languages", ans: 3))
        EqBank.append(Questions(quest: "Ethereum is written in what language?", c1: "Turning", c2: "Python", c3: "Java", ans: 1))
    }
    
    
}
