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
    var name : String
    var image : URL?
    var current_price : Double
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
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json: [String: Any]) throws {
        id = json["id"] as? String ?? ""
        symbol = json["symbol"] as? String ?? ""
        name = json["name"] as? String ?? ""
        image = json["image"] as? URL
        current_price = json["current_price"] as? Double ?? 0.00
        market_cap = json["market_cap"] as? Double ?? 0.00
        market_cap_rank = json["market_cap_rank"] as? Int ?? 0
        total_volume = json["total_volume"] as? Double ?? 0.00
        high_24h = json["high_24h"] as? Double ?? 0.00
        low_24h = json["low_24h"] as? Double ?? 0.00
        price_change_24h = json["price_change_24h"] as? Double ?? 0.00
        price_change_percentage_24h = json["price_change_percentage_24h"] as? Double ?? 0.00
        market_cap_change_24h = json["market_cap_change_24h"] as? Double ?? 0.00
        circulating_supply = json["circulating_supply"] as? String ?? ""
        total_supply = json["circulating_supply"] as? Double ?? 0.00
        ath = json["ath"] as? Double ?? 0.00
        ath_change_percentage = json["ath_change_percentage"] as? Double ?? 0.00
        ath_date = json["ath_date"] as? String ?? ""
        last_updated = json["last_updated"] as? String ?? ""
        
        
    }

}

class MarketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
     private var data: [String] = []
    
//    let imageURLOne = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin"
//    let imageURLTwo = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=ethereum"
//    let imageURLThree = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=ripple"
    
    var listOfCoins = ["https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin","https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=ethereum","https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=ripple"]

 
    
    var coinData = [CoinData]()
    var coinTest = [Any]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = UIColor.gray
        tableView.backgroundColor = UIColor.darkGray
 
//        listOfCoins.append(imageURLOne)
//        listOfCoins.append(imageURLTwo)
//        listOfCoins.append(imageURLThree)
//
//      self.retrieveData()
        createCoinArray() { (stuff) in }
        tableView.reloadData()
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("This many rows: \(coinData.count)")
        return coinData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! MarketTableViewCell
        
        cell.backgroundColor = UIColor.lightGray
        
        if let idName = coinData[indexPath.row].id {
            let idN = String(stringInterpolationSegment: idName)
            cell.nameLabel.text = "\(idN)"
        }
        cell.symbolLabel.text = "\(coinData[indexPath.row].symbol ?? "none")"
        cell.currentPrice.text = String("Current Price: \(coinData[indexPath.row].current_price)")
        if let athLab = coinData[indexPath.row].ath {
            let athLab = String(stringInterpolationSegment: athLab)
            cell.athLabel.text = "ATH: \(athLab)"
        }
        if let atlLab = coinData[indexPath.row].low_24h {
            let low = String(stringInterpolationSegment: atlLab)
            cell.dayLowLabel.text = "24h Low: \(low)"
        }
        if let dayalhLab = coinData[indexPath.row].high_24h {
            let dayHigh = String(stringInterpolationSegment: dayalhLab)
            cell.dayHighLabel.text = "24h High: \(dayHigh)" 
        }
        
        if let opt = coinData[indexPath.row].price_change_24h {
            let dayPChange = String(stringInterpolationSegment: opt)
            cell.dayChangeLabel.text = "24h: \(dayPChange)"
        }
        
        
        cell.linkButton.setTitle("More Info", for: .normal)
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    public func createCoinArray(completionBlock: @escaping ([String:Any]) -> Void) -> Void
    {
        for coin in listOfCoins{
            let requestURL = URL(string: coin)
            let request = URLRequest(url: requestURL!)
            let requestTask = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
                    if(error != nil) {
                        print("Error: \(String(describing: error))")
                } else {
                    do {
                        let json = try JSONDecoder().decode([CoinData].self, from: data!).sorted{ $0.market_cap_rank < $1.market_cap_rank}
                        
                        self.coinData.append(json[0])
                        DispatchQueue.main.async {
                        
                            
                            self.tableView.reloadData()}
                        } catch {
                            print("Didnt work")
                        }
                        
            }
        }
        requestTask.resume()
    }
    
    }
}

