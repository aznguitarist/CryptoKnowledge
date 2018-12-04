//
//  WalletsViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 12/1/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit


class WalletsViewController: UITableViewController {
    
    var cellID = "CellID"
    
    var walletSections = ["Hard", "Apple", "Android", "Web", "Paper"]
    var typesOfWallets = ["Hardware", "IOS", "Android", "Web", "Paper"]
    
    let urlArray = ["https://www.ledger.com/", "https://trezor.io/","https://www.keepkey.com/","https://brd.com/","http://www.sollico.com/bitwallet/", "https://jaxx.io/downloads.html","https://wallet.mycelium.com/","https://www.coinomi.com/en/","https://edge.app/","https://www.blockchain.com/explorer","https://pro.coinbase.com/","https://gemini.com/", "https://www.bitaddress.org","https://bitcoinpaperwallet.com/"]
   
    
    var twoDimensionalArray = [["Ledger", "Trezor", "Keepkey"],["BRD(bread)", "Bitwallet", "Jaxx"],["Mycellium", "Coinomi", "Airbitz"], ["Blockchain.info", "Coinbase","Gemini"],["Bitaddress","Bitcoinpaperwallet"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.pushTransitionTop(1)
        navigationItem.title = "Wallets"
       self.navigationController?.navigationBar.barTintColor = Colors.iconDarkBlue
        navigationController?.navigationBar.isTranslucent = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)

        
    }
 
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
       let label = UILabel()

        if (section == 0) {
            label.text = "Hardware Wallets"
        }
        if (section == 1) {
            label.text = "iOS Wallets"
        }
        if (section == 2 ) {
            label.text = "Android Wallets"
        }
        if (section == 3) {
            label.text = "Web Wallets"
        }
        if (section == 4) {
            label.text = "Paper Wallets"
        }
        
        label.backgroundColor = Colors.iconContrastYellow
        label.font = UIFont(name: label.font.fontName, size: 20)
        return label
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return twoDimensionalArray[section].count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
       
      
        let wallet = twoDimensionalArray[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = "\(wallet)"
        cell.backgroundColor = Colors.iconDarkBlue
        cell.textLabel?.textColor = UIColor.white
        
        return cell 
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = self.urlArray[indexPath.row]
        if let url = URL(string: urlString)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    func handleledger(){
        if let url = NSURL(string: "https://www.google.com/")
        {UIApplication.shared.open(url as URL,  options: [:], completionHandler: nil)
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       navigationController?.navigationBar.barTintColor = UIColor.black.withAlphaComponent(0.1)
        
        
    }
}

