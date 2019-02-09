//
//  MarketViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 12/16/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit
import Dispatch


struct CoinData: Decodable {
    
    var id : String?
    var symbol : String?
    var name : String?
    var image : String?
    var current_price : Double?
    var market_cap: Double?
    var market_cap_rank : Int
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
//    var roi : Double?
    var last_updated : String?
    
    }

class MarketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
     private var data: [String] = []
    
    
    var listOfCoins = ["https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin","https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=ethereum","https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=ripple","https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=monero","https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=tether","https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=litecoin","https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=eos","https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=stellar","https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=iota","https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin-cash","https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin-cash-sv"
        ]

 
    
    var coinData = [CoinData]()
    var coinTest = [Any]()
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addCoin))
        self.title = "Market"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = UIColor.gray
        tableView.backgroundColor = UIColor.darkGray
 
        createCoinArray()
        
        print(listOfCoins)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        tableView.reloadData()
        navigationController?.title = "Market"
    }
    
    func sortCoins() {
        let newCoinArray = coinData.sorted { (id1, id2) -> Bool in
            id1.market_cap_rank < id2.market_cap_rank
        }
        coinData = newCoinArray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows: \(coinData.count)")
        return coinData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! MarketTableViewCell
        cell.backgroundColor = UIColor.lightGray
 
        if let idName = coinData[indexPath.row].name?.uppercased() {
            let idN = String(stringInterpolationSegment: idName)
            cell.nameLabel.text = "\(idN)"
        }
        cell.symbolLabel.text = "\(coinData[indexPath.row].symbol ?? "1")"
       
        
        if let currentP = coinData[indexPath.row].current_price {
            var cp = String(stringInterpolationSegment: currentP)
            cp = String(cp.prefix(8))
            cell.currentPrice.text = "$\(cp)"
        }
        
        if let athLab = coinData[indexPath.row].ath {
            var athLab = String(stringInterpolationSegment: athLab)
            athLab = String(athLab.prefix(8))
            cell.athLabel.text = "ATH: $\(athLab)"
        }
        if let percent = coinData[indexPath.row].price_change_percentage_24h {
            var percent1 = String(stringInterpolationSegment: percent)
            percent1 = String(percent1.prefix(8))
            cell.percentChangeLabel.text = "%: \(percent1)"
        }
        
        if let priceChange = coinData[indexPath.row].price_change_24h {
            if priceChange > 0.0 {
            var pC = String(stringInterpolationSegment: priceChange)
                pC = String(pC.prefix(8))
                cell.dayChangeLabel.text = "$\(pC)"
                cell.dayChangeLabel.textColor = UIColor.green
            } else {
                var pC = String(stringInterpolationSegment: priceChange)
                pC = String(pC.prefix(8))
                cell.dayChangeLabel.text = "24h: \(pC)"
                cell.dayChangeLabel.textColor = UIColor.red}
        }
        if let atlLab = coinData[indexPath.row].low_24h {
            var low = String(stringInterpolationSegment: atlLab)
            low = String(low.prefix(8))
            cell.dayLowLabel.text = "Low: $\(low)"}
        
        if let dayalhLab = coinData[indexPath.row].high_24h {
            var dayHigh = String(stringInterpolationSegment: dayalhLab)
            dayHigh = String(dayHigh.prefix(8))
            cell.dayHighLabel.text = "High: $\(dayHigh)" }
        
        if let opt = coinData[indexPath.row].price_change_24h {
            var dayPChange = String(stringInterpolationSegment: opt)
            dayPChange = String(dayPChange.prefix(8))
            cell.dayChangeLabel.text = "24h: $\(dayPChange)"
        }
        
        if let marketCap = coinData[indexPath.row].market_cap {
            var marketC = String(stringInterpolationSegment: marketCap)
            marketC = String(marketC.prefix(10))
            cell.marketCapLabel.text = "Market: $\(marketC)"
        }
        
        cell.linkButton.setTitle("More Info", for: .normal)
        
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: self.coinData[indexPath.row].image ?? "")
            let data = try? Data(contentsOf: url!)
            let imageCache = NSCache<NSString, UIImage>()
            
            let image: UIImage = UIImage(data: data!)!
            
            DispatchQueue.main.async {
                
                imageCache.setObject(image, forKey: NSString(string: self.coinData[indexPath.row].image!))
                if let cachedImage = imageCache.object(forKey: NSString(string: (self.coinData[indexPath.row].image)!)){
                    cell.logoImageView.image = cachedImage
                } else {
                    DispatchQueue.global(qos: .background).async{
                        let url = URL(string: self.coinData[indexPath.row].image ?? "")
                        let data = try? Data(contentsOf: url!)
                        let imageCache = NSCache<NSString, UIImage>()
                        let image: UIImage = UIImage(data: data!)!
                         imageCache.setObject(image, forKey: NSString(string: self.coinData[indexPath.row].image!))
                    }
                  
                }
                }
                    
                }
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100}
    
    public func createCoinArray() {
        for coin in listOfCoins{
            let requestURL = URL(string: coin)
            let request = URLRequest(url: requestURL!)
            let requestTask = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
                    if(error != nil) {
                        print("Error: \(String(describing: error))")
                } else {
                    do {
                        let json = try JSONDecoder().decode([CoinData].self, from: data!)
                       self.coinData.append(json[0])
                        DispatchQueue.main.async {
                          self.sortCoins()
                            self.tableView.reloadData()
                        }
                        
                        } catch {
                            print("Didnt work")
                        }
            }
        }
        requestTask.resume()
    }
    
    }
    
    @objc func addCoin(){
//        let addCoin = AddCoinToMarketViewController()
//        present(addCoin, animated: true, completion: nil)
        performSegue(withIdentifier: "AddCoin", sender: self)
    }
    
}

