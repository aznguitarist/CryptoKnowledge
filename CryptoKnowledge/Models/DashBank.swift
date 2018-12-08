//
//  DashBank.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 12/5/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation

class DashBank {
    var DashBank = [Questions]()
    
    
    init() {
    
        DashBank.append(Questions(quest: "Dash is a(n) .....", c1: "Open-source cryptocurrency", c2: "Privatized Blockchain", c3: "Government ran blockchain", ans: 1))
        DashBank.append(Questions(quest: "What does the acronym 'DAO' mean?", c1: "Digiatized Assets Organization", c2: "Decentralized Autonomous Organization ", c3: "Direct Access Operations", ans: 2))
        DashBank.append(Questions(quest: "Who runs the DAO?", c1: "Binance", c2: "Miners", c3: "Masternodes", ans: 3))
        DashBank.append(Questions(quest: "Which protocol was Dash forked from?", c1: "Bitcoin", c2: "Ethereum", c3: "Monero", ans: 1))
        DashBank.append(Questions(quest: "Dash allows transactions that are...", c1: "Free", c2: "Untraceable", c3: "Trackable", ans: 2))

        DashBank.append(Questions(quest: "What percentage of mined coins go to mines?", c1: "25%", c2: "35%", c3: "45%", ans: 3))
        DashBank.append(Questions(quest: "What percentage of mined coins go to masternodes?", c1: "25%", c2: "35%", c3: "45%", ans: 3))
        DashBank.append(Questions(quest: "What percentage of mined coins go to the DAO?", c1: "10%", c2: "20%", c3: "30%", ans: 1))
        DashBank.append(Questions(quest: "When was Dash launched?", c1: "January 2014", c2: "January 2015", c3: "January 2016", ans: 3))
        DashBank.append(Questions(quest: "What was Dash originally launched as?", c1: "DAO Coin", c2: "XCoin", c3: "Zcoin", ans: 2))
        
        DashBank.append(Questions(quest: "Where does 'Dash' come from?", c1: "Decentralized Cash", c2: "Dark Cash", c3: "Digital Cash", ans: 3))
        DashBank.append(Questions(quest: "Along with masternodes, Dash has...", c1: "Regular nodes", c2: "Miners", c3: "Both", ans: 3))
        DashBank.append(Questions(quest: "In order to run a masternode, how many Dash coins does one need?", c1: "10", c2: "100", c3: "1000", ans: 3))
        DashBank.append(Questions(quest: "In addition to 1000 coins, a masternodes also needs...", c1: "An account with the DAO", c2: "A static IP address", c3: "To register with the SEC", ans: 2))
        DashBank.append(Questions(quest: "What protocol ensures that masternodes have the most current blockchain protocol and are online?", c1: "Proof-of-Service", c2: "Proof-of-Work", c3: "Proof-of-Stake", ans: 1))
        
        DashBank.append(Questions(quest: "Who can vote on protocol changes?", c1: "Masternodes", c2: "Miners", c3: "Both", ans: 1))
        DashBank.append(Questions(quest: "How many Dash were mined on the first day?", c1: "1 Million", c2: "2 Million", c3: "3 Million", ans: 2))
        DashBank.append(Questions(quest: "As of 2018, Dash is mined using what kind of algorithm?", c1: "Proof-of-Stake", c2: "Proof-of-Work", c3: "Proof-of-Life", ans: 2))
        DashBank.append(Questions(quest: "What is Dash's hash function they use?", c1: "X11", c2: "D11", c3: "Z11", ans: 1))
        DashBank.append(Questions(quest: "How often is a new block mined as of 2018?", c1: "2.5 Minutes", c2: "5 Minutes", c3: "10 Minutes", ans: 1))
        
        DashBank.append(Questions(quest: "What is another type of transaction that Dash can perform?", c1: "InstantSend", c2: "FastSend", c3: "MultipleSend", ans: 1))
        DashBank.append(Questions(quest: "What is an 'InstantSend' transaction?", c1: "A transaction that only needs a consenus of masternodes to validate the transaction", c2: "A transaction that needs no confirmation to be secure", c3: "A way of instantly creating a new block", ans: 1))
        DashBank.append(Questions(quest: "In addition to InstantSend Transactions, Dash can handle another speical type of transaction called....", c1: "SecretSend", c2: "PrivateSend", c3: "DarkSend", ans: 2))
        DashBank.append(Questions(quest: "Which company now offers electronic payments using Dash in the USA Cannabis industry?", c1: "Dash.co", c2: "Alt Thirty Six", c3: "Digico", ans: 2))
        DashBank.append(Questions(quest: "The total supply that will possibly be mined is...", c1: "18 Million", c2: "21 Million", c3: "22 Million", ans: 3))
        
        DashBank.append(Questions(quest: "What is the block reward for the miners? ", c1: "Varies depends on the amount of miners", c2: "12.5 Dash", c3: "50 Dash", ans: 1))
        DashBank.append(Questions(quest: "As of December 2018, how much are the block rewards?", c1: "2.25 Dash", c2: "3.35 Dash", c3: "4.45 Dash", ans: 2))
        DashBank.append(Questions(quest: "By about how much does the block rewards decrease each year?", c1: "5%", c2: "7%", c3: "10%", ans: 2))
    }
}
