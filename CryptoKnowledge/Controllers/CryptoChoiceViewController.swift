//
//  CryptoChoiceViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/29/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit
import Firebase


class CryptoChoiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var coins: [Coins] = []
    var segueIdentifiers = ["cryptoquiz","bitcoin","ethereum","rippleSegue"]
    let navItem = UINavigationItem()
    var cryptoScore = ""
    var btcScore = ""
    var etherScore = ""
    var rippleScore = "none"
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @objc func goBackToLogin() {
        
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? UIViewController else {
                return
            }
            present(mainRegistrationVC, animated: true, completion: nil)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CryptoKnowledge"
//     view.setGradientBackground(oneColor: UIColor.blue , twoColor: UIColor.black)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(goBackToLogin))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.barTintColor = Colors.darkPurple
        //       self.navigationController?.navigationBar.shadowImage = UIImage()
       self.navigationController?.navigationBar.isOpaque = true
        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.isTranslucent = true
         tableView.backgroundColor = Colors.blackPurple2
        
        coins = createArray()
        
    
        // Do any additional setup after loading the view.
        
   
        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.tableFooterView = UIView()
//        tableView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.rowHeight = UITableView.automaticDimension
       
     
        tableView.reloadData()
        
    }
    
   
    func createArray() -> [Coins] {
        
       
        let userScoresAndQuestNumb = UserDefaults.standard
        let cryptoScore = userScoresAndQuestNumb.integer(forKey: "score")
        let btcScore = userScoresAndQuestNumb.integer(forKey: "BTC Score")
        let etherScore = userScoresAndQuestNumb.integer(forKey: "Ether Score")
        let rippleScore = userScoresAndQuestNumb.integer(forKey: "Ripple Score")
        var tempCoins: [Coins] = []
        
        let coin1 = Coins(image: UIImage(named: "cryptoquiz coin")!, name: "Crypto Quiz", progress: "Score: \(cryptoScore)" , controller: "CryptoViewController")
        let coin2 = Coins(image: UIImage(named: "bitcoin")!, name: "Bitcoin", progress: "Score: \(btcScore)", controller: "BtcViewController")
        let coin3 = Coins(image: UIImage(named: "Ethereum")!, name: "Ethereum", progress: "Score: \(etherScore)", controller: "EthereumViewController")
        let coin4 = Coins(image: UIImage(named: "ripple")!, name: "Ripple", progress: "Score: \(rippleScore)", controller: "RippleViewController" )
//        let coin5 = Coins(image: UIImage(named: "litecoin")!, name: "Litcoin")
        

        tempCoins.append(coin1)
        tempCoins.append(coin2)
        tempCoins.append(coin3)
        tempCoins.append(coin4)
//        tempCoins.append(coin4)
//        tempCoins.append(coin5)
        
        tableView.reloadData()
        return tempCoins
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coin = coins[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as! CryptoCellTableViewCell
        
        cell.setCoin(coin: coin)
//        cell.progressLabel.shadowColor = UIColor.darkGray
        cell.progressLabel.layer.shadowOffset = CGSize(width: 5, height: 10)
        cell.progressLabel.layer.shadowOpacity = 0.5
        cell.coinLabel.layer.shadowOffset = CGSize(width: 5, height: 10)
        cell.coinLabel.layer.shadowOpacity = 0.5
        cell.coinImageView.layer.shadowOpacity = 0.5
        cell.coinImageView.layer.shadowOffset = CGSize(width: 5, height: 10)
    
        cell.backgroundColor = UIColor.clear
//       cell.setGradientBackground2(oneColor: UIColor.black, twoColor: UIColor.blue)
    
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifiers[indexPath.row], sender: self)    }
 

}

