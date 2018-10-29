//
//  CryptoChoiceViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/29/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit

class CryptoChoiceViewController: UIViewController {

    var coins: [Coins] = []
    
    
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
        
        let coin1 = Coins(image: UIImage(named: "cryptoquiz coin")!, name: "Crypto Quiz")
        let coin2 = Coins(image: UIImage(named: "bitcoin")!, name: "Bitcoin")
        let coin3 = Coins(image: UIImage(named: "Ethereum")!, name: "Ethereum")
        let coin4 = Coins(image: UIImage(named: "ripple")!, name: "Ripple") 
        let coin5 = Coins(image: UIImage(named: "litecoin")!, name: "Litcoin")
        
        tempCoins.append(coin1)
        tempCoins.append(coin2)
        tempCoins.append(coin3)
        tempCoins.append(coin4)
        tempCoins.append(coin5)
        
        
        return tempCoins
    }
    

}


extension CryptoChoiceViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coin = coins[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as! CryptoCellTableViewCell
        
        cell.setCoin(coin: coin)
        
        return cell
    }

}



