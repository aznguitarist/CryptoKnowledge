//
//  CryptoCellTableViewCell.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/29/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit
import Firebase

class CryptoCellTableViewCell: UITableViewCell {

    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
    
    
    func setCoin(coin: Coins){
        coinImageView.image = coin.image
        coinLabel.text = coin.name
        progressLabel.text = coin.progress
        progressLabel.font = progressLabel.font.withSize(15.0)
    }
    
    
    
    func fetchFireUserData(){
        let ref = FIRDatabase.database().reference()
        guard let uid = FIRAuth.auth()?.currentUser!.uid else {
            return}
        }
        }
