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
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var dayChangeLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var dayLowLabel: UILabel!
    
    @IBOutlet weak var dayHighLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
