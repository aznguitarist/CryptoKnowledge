 //
//  MarketTableViewCell.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 12/16/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit

class MarketTableViewCell: UITableViewCell {


    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var athLabel: UILabel!
    
    @IBOutlet weak var percentChangeLabel: UILabel!
    
    
    @IBOutlet weak var marketCapLabel: UILabel!
    
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var dayChangeLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var dayLowLabel: UILabel!
    
    @IBOutlet weak var dayHighLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       logoImageView.layer.borderColor = UIColor.black.cgColor
        logoImageView.layer.borderWidth = 2
        logoImageView.layer.cornerRadius = 10
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
