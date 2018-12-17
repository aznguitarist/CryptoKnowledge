//
//  MarketViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 12/16/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit

struct CoinData: Codable {
    
    var id : String?
    var symbol : String?
    var name : String?
    var image : URL?
    var current_price : Double?
    var market_cap: Double?
    var market_cap_rank : Int?
    var total_volume : Double?
    var high_24h : Double?
   var low_24h : Double?
    var price_change_24h : Double?
   var price_change_percentage_24h : Double?
   var market_cap_change_24h : Double?
   var market_cap_change_percentage_24h : Double?
    var circulating_supply : String?
    var total_supply : Double?
    var ath : Double?
    var ath_change_percentage : Double?
    var ath_date : String?
    var roi : Double?
    var last_updated : String?
    
}

class MarketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
     private var data: [String] = []
        let imageURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&per_page=10&sparkline=true"
    
    var coinData = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        guard let url = URL(string: imageURL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            print(data)
            do{
                let crypto = try JSONDecoder().decode([CoinData].self, from: data)
                
                self.coinData.append(crypto[0].name!)
                let currentPrice = "Price: \(crypto[0].current_price ?? 0)"
                
                self.coinData.append(currentPrice)
                self.coinData.append("24H High: \(String(describing: crypto[0].high_24h))")
                print(self.coinData)
                print(crypto)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("error", error)
            }
            
        }.resume()
        
        
        tableView.delegate = self
       tableView.dataSource = self
       tableView.reloadData()
        view.backgroundColor = UIColor.gray
        tableView.backgroundColor = UIColor.darkGray
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return coinData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! MarketTableViewCell
        
        cell.backgroundColor = UIColor.lightGray
        cell.nameLabel.text = coinData[indexPath.row]
        
    
 
        
        return cell
    }
    
    
}
