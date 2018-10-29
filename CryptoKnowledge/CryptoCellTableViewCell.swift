//
//  CryptoCellTableViewCell.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/29/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit

class CryptoCellTableViewCell: UITableViewCell {

 
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var coinLabel: UILabel!
    
    func setCoin(coin: Coins){
        coinImageView.image = coin.image
        coinLabel.text = coin.name
    }
    
}
