//
//  CryptoChoiceViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/29/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit

class CryptoChoiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var coins: [Coins] = []
    var segueIdentifiers = ["cryptoquiz","bitcoin","ethereum"]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

           coins = createArray()
        
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func createArray() -> [Coins] {
        var tempCoins: [Coins] = []
        
        let coin1 = Coins(image: UIImage(named: "cryptoquiz coin")!, name: "Crypto Quiz", controller: "CryptoViewController")
        let coin2 = Coins(image: UIImage(named: "bitcoin")!, name: "Bitcoin", controller: "BtcViewController")
        let coin3 = Coins(image: UIImage(named: "Ethereum")!, name: "Ethereum", controller: "EthereumViewController")
//        let coin4 = Coins(image: UIImage(named: "ripple")!, name: "Ripple", controller: "RippleViewContro )
//        let coin5 = Coins(image: UIImage(named: "litecoin")!, name: "Litcoin")
//
        tempCoins.append(coin1)
        tempCoins.append(coin2)
        tempCoins.append(coin3)
//        tempCoins.append(coin4)
//        tempCoins.append(coin5)
        
        
        return tempCoins
    }
    


   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coin = coins[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as! CryptoCellTableViewCell
        
        cell.setCoin(coin: coin)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifiers[indexPath.row], sender: self)    }
 

}




