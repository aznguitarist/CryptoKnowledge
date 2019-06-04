//
//  MoneroBank.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 11/28/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit

class MoneroBank {
        var MoneroBank = [Questions]()
        
        init(){
            
            MoneroBank.append(Questions(quest: "What is Monero's ticker symbol? ", c1: "MON", c2: "XMR", c3: "MOE", ans: 2))
            MoneroBank.append(Questions(quest: "When was Monero created?", c1: "April 2014", c2: "May 2014", c3: "June 2014", ans: 1))
            MoneroBank.append(Questions(quest: "What does Monero focus on?", c1: "Fungibility, Privacy, and Decentralization ", c2: "Acting as a stable coin", c3: "Being a way of frictionless transactions", ans: 1))
            MoneroBank.append(Questions(quest: "What does 'monero' mean in Esperanto", c1: "Money", c2: "Coin", c3: "Currency", ans: 2))
            MoneroBank.append(Questions(quest: "How often is a new block created?", c1: "2 Minutes", c2: "5 Minutes", c3: "10 Minutes", ans: 1))
            
            MoneroBank.append(Questions(quest: "Who created Monero?", c1: "A core 7 developers", c2: "A Satoshi Nakamoto and Justin Ver", c3: "Chinese Government", ans: 1))
            MoneroBank.append(Questions(quest: "What kind of crypto-currency is Monero considered?", c1: "Stable Coin", c2: "Commodity Coin", c3: "Private Coin", ans: 3))
            MoneroBank.append(Questions(quest: "What will the total supply be of Monero?", c1: "21 Million", c2: "18.4 + .3 every minute", c3: "3 Billion", ans: 2))
            MoneroBank.append(Questions(quest: "What type of protocol does it use?", c1: "Proof of Stake", c2: "Proof of Privacy", c3: "Proof of Work", ans: 3))
            MoneroBank.append(Questions(quest: "What is the average transaction fee?", c1: "1-5XMR/kb", c2: "0.1-0.2XMR/kb", c3: "0.004-0.02XMR/kB", ans: 3))
            
            MoneroBank.append(Questions(quest: "How are Monero transactions made private?", c1: "They use ring signatures.", c2: "A special algorithm called 'PrivaHash", c3: "Mixing the coins in other blockchains.", ans: 1))
            MoneroBank.append(Questions(quest: "What are ring signatures?", c1: " A Digital signature that can be performed by any member of a group of users that each have keys", c2: "A portal that all transactions must go through.", c3: "A trusted third party that shakes the coins and then sends them to the reciever.", ans: 1))
            MoneroBank.append(Questions(quest: "What is the main algorithm Monero uses come from?", c1: "Monte's privatized hash", c2: "Proof-of-work hash algorithm", c3: "Mixers data algorithm", ans: 2))
            MoneroBank.append(Questions(quest: "Who created the 'proof-of-work hash algorithm?", c1:"CryptoNote", c2: "Anonymous", c3: "Cypherpunks", ans: 1))
            MoneroBank.append(Questions(quest: "What was Monero designed to be resistant to?", c1: "Goverment interference", c2: "Paying taxes", c3: "ASIC Mining", ans: 3))
            
            MoneroBank.append(Questions(quest: "What is the amount of XMR in cirrculation as of December 2018?", c1: "20.5 Million", c2: "16.6 Million", c3: "10.7 Million", ans: 2))
            MoneroBank.append(Questions(quest: "What makes it impossible for someone to discover the destination address of a transaction?", c1: "Stealth addresses", c2: "Black addresses", c3: "Covert addresses", ans: 1))
            MoneroBank.append(Questions(quest: "How many core developers are working on Monero?", c1: "39", c2: "49", c3: "59", ans: 2))
            MoneroBank.append(Questions(quest: "What do 'Confidential Transactions' do?", c1: "Hides the amounts being transacted", c2: "Hides the senders address", c3: "Hides the recievers address", ans: 1))
            MoneroBank.append(Questions(quest: "Who created the confidential transactions algorithm?", c1: "Justin Sun", c2: "Barry Silbert", c3: "Gregory Maxwell", ans: 3))
            
            MoneroBank.append(Questions(quest: "What type of blockchain is Monero?", c1: "Obfuscated", c2: "Centralized", c3: "Shadow", ans: 1))
            MoneroBank.append(Questions(quest: "What does 'obfuscated' mean?", c1: " Obscuring of the intended meaning of communication by making the message difficult to understand", c2: "To observe and record in a secret code", c3: "To overestimate the speed and timing of a transaction", ans: 1))
            MoneroBank.append(Questions(quest: "Who is most likely to benefit from using Monero?", c1: "The government", c2: "Unbanked", c3: "People who do nefarious activities", ans: 3))
            MoneroBank.append(Questions(quest: "How many developers have contributed to the development of Monero?", c1: "320", c2: "420", c3: "520", ans: 2))
            MoneroBank.append(Questions(quest: "What was Monero formerly known as? ", c1: "CryptoNote", c2: "Bitmonero", c3: "Obfuscoin", ans: 2))
            
            
        }
    }

