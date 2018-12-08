//
//  EOSBank.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 12/4/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation

class EOSBank {
    
    var EOSBank = [Questions]()
    
    init() {
        
        EOSBank.append(Questions(quest: "What attributes does EOS mostly Emulate? ", c1: "Bitcoin", c2: "A computer", c3: "Ripple", ans: 2))
        EOSBank.append(Questions(quest: "How are the resources distributed?", c1: "Equally among EOS cryptocurrency holders", c2: "Among the top 10 miners", c3: "Randomly between the EOS holders and miners", ans: 1))
        EOSBank.append(Questions(quest: "What type of platform does EOS claim to be?", c1: "Gaming", c2: "Smart Contract", c3: "Free Speech", ans: 2))
        EOSBank.append(Questions(quest: "When was the inital release?", c1: "January 31, 2016", c2: "January 31, 20017", c3: "January 31, 2018", ans: 3))
        EOSBank.append(Questions(quest: "About how many EOS tokens are in circulation? ", c1: "800 Million", c2: "900 Million", c3: "1 Billion", ans: 2))
        
        EOSBank.append(Questions(quest: "What language was EOS written in?", c1: "Java Script", c2: "Python", c3: "C++", ans: 3))
        EOSBank.append(Questions(quest: "Which company developed EOS?", c1: "Blockchain.info", c2: "block.one", c3: "Coinbase", ans: 2))
        EOSBank.append(Questions(quest: "How many tokens were released at the launch of the blockchain?", c1: "1 Million", c2: "1 Billion", c3: "100 Billion", ans: 2))
        EOSBank.append(Questions(quest: "How much did block.one want to raise with their ICO?", c1: "$1 Billion", c2: "$2 Billion", c3: "$3 Billion", ans: 1))
        EOSBank.append(Questions(quest: "How much funding did they initially get from their ICO?", c1: " One Billon Dollars", c2: "Three Billion Dollars", c3: "4 Billion Dollars", ans: 3))
        
        EOSBank.append(Questions(quest: "What two problems with bitcoin does EOS claim to fix?", c1: "Scalibility and Centralization", c2: "Fees and Energy Consumption", c3: "Scalibility and Fees", ans: 3))
        EOSBank.append(Questions(quest: "What is one way EOSIO claims to have fixed the problems with bitcoin?", c1: "Mulit-threading", c2: "LAHASH Algorithm", c3: "Master Nodes", ans: 1))
        EOSBank.append(Questions(quest: "What is the second way EOSIO claims to have fixed the problems with bitcoin?", c1: "Delegated Proof-of-Stake", c2: "Master Nodes", c3: "Tangle Technlogy", ans: 1))
        EOSBank.append(Questions(quest: "What is Multi-Threading?", c1: "The ability to send more than one transaction", c2: "The ability to run on multiple computer cores", c3: "The ability to stitch together multiple transactions", ans: 2))
        EOSBank.append(Questions(quest: "EOS is what type of token?", c1: "Stable", c2: "Private", c3: "Utility", ans: 3))
        
        EOSBank.append(Questions(quest: "Why is EOS considered a utility token?", c1: "It provides both bandwidth and storage", c2: "It pays you for the energy used to mine the token", c3: "It can be used to trade stocks", ans: 1))
        EOSBank.append(Questions(quest: "Owning EOS allows you to _______.", c1: "Vote on the governance of EOS's development", c2: "Buy bandwidth from Google", c3: "Pay for hosting your website", ans: 1))
        EOSBank.append(Questions(quest: "How often is a new block mined?", c1: "1 second", c2: "500 ms", c3: "250 ms", ans: 2))
        EOSBank.append(Questions(quest: "How many characters is the name of an account?", c1: "10", c2: "12", c3: "15", ans: 2))
        EOSBank.append(Questions(quest: "What can you buy and from the eosio system? ", c1: "Ram", c2: "Storage", c3: "GPU", ans: 1))
        
        EOSBank.append(Questions(quest: "What is EOS.IO Storage System?", c1: "A Decentralized File System", c2: "A Web Server", c3: "A Link to exchanges to buy and sell other cryptocurrencies", ans: 1))
        EOSBank.append(Questions(quest: "Who provides the storage?", c1: "Exchanges", c2: "Token Holders", c3: "Block Producers", ans: 3))
        EOSBank.append(Questions(quest: "How do you use the storage and bandwidth provided by the block producers?", c1: "Owning EOS tokens", c2: "Pay the exchanges that trade EOS", c3: "Buying space from cloud storage providers like AWS and Google", ans: 1))
        EOSBank.append(Questions(quest: "Where is EOSIO registered as a company?", c1: "USA", c2: "England", c3: "Cayman Islands", ans: 3))
        EOSBank.append(Questions(quest: "What does EOS mean?", c1: "Ethernet Over SONET", c2: "Electronic Online Services", c3: "Election Over Services", ans: 1))
        
        
        
        print(EOSBank.count)
        
    }
    
    
}
