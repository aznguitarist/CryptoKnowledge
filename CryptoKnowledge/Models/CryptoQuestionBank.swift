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
        cryptoBank.append(Questions(quest: "What is Blockchain technology best described as?", c1: "A distributed chain of blocks that contain information on transactions.", c2: "A list of who owns a certain crypto-currency.", c3: "A chain of organizations and people who share information.", ans: 1))
        cryptoBank.append(Questions(quest: "What does the acryonym 'ICO' stand for?", c1: "Initial Currency Offering", c2: "Initial Coin Offering", c3: "Independent Currency Offering", ans: 2))
        cryptoBank.append(Questions(quest: "What are the safest types of wallets? ", c1: "Hardware", c2: "Phone", c3: "Online", ans: 1))
        cryptoBank.append(Questions(quest: "What does it mean if you store your crypto in a cold wallet?", c1: "You put it in the fridge.", c2: "You put it in wallet that's diconnected to the internet", c3: "You put your crypto in a wallet that is connected to the internet", ans: 2))
        //5
        cryptoBank.append(Questions(quest: "Exodus is an example of what type of wallet?", c1: "Paper Wallet", c2: "Hot wallet", c3: "Cold Wallet", ans: 2))
        cryptoBank.append(Questions(quest: "What does decentralized mean?", c1: "It's not controlled by the government.", c2: "Its not controlled by a company", c3: "Both", ans: 3))
        cryptoBank.append(Questions(quest: "What type of wallet is the Ledger Nano? ", c1: "Hardware", c2: "Paper", c3: "Hot", ans: 1))
        cryptoBank.append(Questions(quest: "How many crypto-currencies are in existant?", c1: "100-200", c2: "1,000-2,000", c3: "2,000-3,000", ans: 2))
        cryptoBank.append(Questions(quest: "What site is used to find market data on almost all crypto-currencies.", c1: "coinmarketcap.com", c2: "Coinbase.com", c3: "coins.com", ans: 1))
        //10
        cryptoBank.append(Questions(quest: "Which isn't a category of cryptocurrency? ", c1: "Stable coins", c2: "Private coins", c3: "Sky coins", ans: 3))
        cryptoBank.append(Questions(quest: "One benefit of blockchain is..", c1: "The ability to have a decentralized currency", c2: "Be the sole owner of the company.", c3: "Makes tracking transactions more difficult.", ans: 1))
        cryptoBank.append(Questions(quest: "How should you pay your taxes if you sell crypto currency in the USA? ", c1: "30% of the total recieved.", c2: "Short-term investment if held less than a year, Long-term investment if held longer than a year.", c3: "Don't need to pay taxes because it's not fiat currency.", ans: 2))
        cryptoBank.append(Questions(quest: "What way determins the ability and probibility a miner will be rewarded for mining a block?", c1: "Proof of Identity", c2: "Proof of Work", c3: "Proof of Power", ans: 1))
        cryptoBank.append(Questions(quest: "A more power effecient way determining the likelyhood of a miner discovering a new block over POW.", c1: "Proof of Stake", c2: "Proof of Ownership", c3: "Proof of Coin", ans: 1))
        //15
        cryptoBank.append(Questions(quest: "What does a block store?", c1: "Transactions", c2: "Sender and Reciever", c3: "Both", ans: 3))
        cryptoBank.append(Questions(quest: "In addition to transatcions and participants what else is stored in a block?", c1: "The previous block's hash", c2: "The owner of the block.", c3: "Block Identifiers", ans: 1))
        cryptoBank.append(Questions(quest: "What is a confirmation?", c1: "It verifies the transactions", c2: "It checks your identity is linked to your address.", c3: "It confirms you did the transaction on the right blockchain", ans: 1))
        cryptoBank.append(Questions(quest: "Why are confirmations important?", c1: "It's what stops double spending", c2: "It confirms your identity.", c3: "Checks your bank account to make sure the sender has enough funds", ans: 1))
        cryptoBank.append(Questions(quest: "What is a 'Double Spend?'", c1: "The spending of the exact same coin.", c2: "The reciever is given two of the same coins.", c3: "The mining of two blocks as the same time.", ans: 1))
        //20
        cryptoBank.append(Questions(quest: "Where is the blockchain stored?", c1: "Each wallet has a copy?", c2: "Each node has a copy.", c3: "Both", ans: 2))
        cryptoBank.append(Questions(quest: "What should you give if you are the reciever?", c1: "Private address", c2: "Public address", c3: "Your name and Private address", ans: 2))
        cryptoBank.append(Questions(quest: "Who can view a transaction that has been made?", c1: "The government", c2: "Anybody", c3: "Only the reciver and sender", ans: 2))
        cryptoBank.append(Questions(quest: "How many wallets or address can you own?", c1: "100", c2: "1000", c3: "As many as you want", ans: 3))
        cryptoBank.append(Questions(quest: "How are blocks stored?", c1: "Linearly and Chronologically", c2: "Size of the block", c3: "Largest transactions", ans: 1))
        
        
        
        
        
    }
}
