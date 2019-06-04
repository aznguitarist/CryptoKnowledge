//
//  Cardano.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 12/6/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation


class CardanoBank {
    var cardanoBank = [Questions]()
    
    init() {
        
        cardanoBank.append(Questions(quest: "What is Cardano's ticker symbol?", c1: "CRD", c2: "ADA", c3: "CAN", ans: 2))
        cardanoBank.append(Questions(quest: "What is the only wallet that supports ADA?", c1: "BRD", c2: "Coinbase", c3: "Daedalus", ans: 3))
        cardanoBank.append(Questions(quest: "Who is the founder of Cardano?", c1: "Charles Hoskinson", c2: "Justin Sun", c3: "Roger Ver", ans: 1))
        cardanoBank.append(Questions(quest: "What type of algorithm does Cardano use?", c1: "Proof-of-Work", c2: "Proof-of-Stake", c3: "Proof-of-Miner", ans: 2))
        cardanoBank.append(Questions(quest: "What is the name of the Proof-of-Stake algorithm?", c1: "Ouroboros", c2: "Candosis", c3: "Quickiling", ans: 1))
        
        cardanoBank.append(Questions(quest: "What is one of the main problems with Ethereum that ADA is trying to fix?", c1: "Scalibility", c2: "Workibility", c3: "Durability", ans: 1))
        cardanoBank.append(Questions(quest: "What is the name of the company that is developing ADA?", c1: "Stellar", c2: "Input Output Hong Kong", c3: "Mt. Gox", ans: 2))
        cardanoBank.append(Questions(quest: "What other blockchain did Charles Hoskinson help cofound?", c1: "Stellar", c2: "Bitcoin", c3: "Ethereum", ans: 3))
        cardanoBank.append(Questions(quest: "__________ is one of the main objectives of Cardano", c1: "Creating smart contracts", c2: "Offering financial services", c3: "Providing a more efficient way of remittance", ans: 1))
        cardanoBank.append(Questions(quest: "Who creates new blocks?", c1: "Miners", c2: "Exchanges", c3: "Slot Leaders", ans: 3))
        
        cardanoBank.append(Questions(quest: "What does it mean to have a 'stake' in Cardano?", c1: "Have a node that has a portion of your balance locked into a 'proxy signing key' which allows special rights", c2: "A balance of ADA tokens in a delegated wallet for voting rights", c3: "Buy special miner rights with ADA.", ans: 1))
        cardanoBank.append(Questions(quest: "In order to become a 'Stakeholder' and particpate in the Cardano protocol, what must you have?", c1: "A postitive stake", c2: "100 ADA tokens", c3: "Only a wallet with the private and public key", ans: 1))
        cardanoBank.append(Questions(quest: "How do you become a 'Slot Leader'?", c1: "Be a stakeholder", c2: "Be voted in by other stakeholders", c3: "Both", ans: 3))
        cardanoBank.append(Questions(quest: "What can't you do with staked coins?", c1: "Vote", c2: "Become a Slot Leader", c3: "Spend them", ans: 3))
        cardanoBank.append(Questions(quest: "Slot leaders can also create________.", c1: "New Blockchains", c2: "New Energy", c3: "New government back currency", ans: 1))
        
        cardanoBank.append(Questions(quest: "What does the 'Ouroboros protocol' divides the physical time into?", c1: "Strings", c2: "Blocks", c3: "Epochs", ans: 3))
        cardanoBank.append(Questions(quest: "Epochs are subdivided into smaller sections. What are they called?", c1: "Blocks", c2: "Slots", c3: "Segments", ans: 2))
        cardanoBank.append(Questions(quest: "A slot leader can produce how many blocks in it's slot?", c1: "1", c2: "2", c3: "3", ans: 1))
        cardanoBank.append(Questions(quest: "The number of slots in an epoch is equal to______", c1: "The total number of previous epochs", c2: "The number of transactions divided by 10", c3: "The number of slot leaders", ans: 3))
        cardanoBank.append(Questions(quest: "Slot leaders can be looked as ______ on the bitcoin blockchain.", c1: "Users", c2: "Miners", c3: "Wallets", ans: 2))
        
        cardanoBank.append(Questions(quest: "Why can Cardano theoretically scale both vertically and horizontally?", c1: "It has the ability to run an instant confirming blockchain", c2: "It has the ability to create multiple epochs", c3: "It dosen't need electricity to work", ans: 2))
        cardanoBank.append(Questions(quest: "What is the estimated current supply of ADA in 2019", c1: "10 Billion", c2: "16 Billion", c3: "26 Billion", ans: 3))
        cardanoBank.append(Questions(quest: "When was Cardano's Settlement Layer released?", c1: "September, 2016", c2: "September, 2017", c3: "September 2018", ans: 2))
        cardanoBank.append(Questions(quest: "How is ADA mined?", c1: " 10 every 20 seconds", c2: "100 every 2 minutes", c3: "It's no mined, but when tokens are rewarded, it's done on the percentage of tokens that are staked.", ans: 3))
        cardanoBank.append(Questions(quest: "How often is a new block created?", c1: "20 Second", c2: "30 Seconds", c3: "1 Minute", ans: 1)) 
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
}
