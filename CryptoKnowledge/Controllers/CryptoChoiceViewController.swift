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
    var segueIdentifiers = ["cryptoquiz","bitcoin","ethereum","rippleSegue","moneroSegue"]
    let navItem = UINavigationItem()
    var cryptoScore = ""
    var btcScore = ""
    var etherScore = ""
    var rippleScore = ""
    var moneroScore = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @objc func goBackToLogin() {
        
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "Menu") as? UIViewController else {
                return
            }
            present(mainRegistrationVC, animated: true, completion: nil)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.pushTransitionLeft(5)
        tableView.pushTransitionRightSlow(5)
        
        self.title = "CryptoKnowledge"
//     view.setGradientBackground(oneColor: UIColor.blue , twoColor: UIColor.black)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackToLogin))
        navigationItem.leftBarButtonItem?.tintColor = Colors.iconContrastYellow
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:Colors.iconContrastYellow]
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.barTintColor = Colors.iconDarkBlue
        //       self.navigationController?.navigationBar.shadowImage = UIImage()
//       self.navigationController?.navigationBar.isOpaque = true
//       navigationController?.navigationBar.isTranslucent = true

        tableView.backgroundColor = Colors.iconDarkBlue
        
       
        
        coins = createArray()
        tableView.reloadData()
        
    }
    

    
    func createArray() -> [Coins] {
        let userScoresAndQuestNumb = UserDefaults.standard
        let cryptoScore = userScoresAndQuestNumb.integer(forKey: "score")
        let btcScore = userScoresAndQuestNumb.integer(forKey: "BTC Score")
        let etherScore = userScoresAndQuestNumb.integer(forKey: "Ether Score")
        let rippleScore = userScoresAndQuestNumb.integer(forKey: "Ripple Score")
        let moneroScore = userScoresAndQuestNumb.integer(forKey: "Monero Score")
        var tempCoins: [Coins] = []
        
        let coin1 = Coins(image: UIImage(named: "cryptoquiz coin")!, name: "Blockchain", progress: "Score: \(cryptoScore)" , controller: "CryptoViewController")
        let coin2 = Coins(image: UIImage(named: "bitcoin")!, name: "Bitcoin", progress: "Score: \(btcScore)", controller: "BtcViewController")
        let coin3 = Coins(image: UIImage(named: "Ethereuma")!, name: "Ethereum", progress: "Score: \(etherScore)", controller: "EthereumViewController")
        let coin4 = Coins(image: UIImage(named: "ripple")!, name: "Ripple", progress: "Score: \(rippleScore)", controller: "RippleViewController" )
        let coin5 = Coins(image: UIImage(named: "monerosmall")!, name: "Monero", progress: "Score: \(moneroScore)", controller: "MoneroViewController")
//        let coin5 = Coins(image: UIImage(named: "litecoin")!, name: "Litcoin")
        

        tempCoins.append(coin1)
        tempCoins.append(coin2)
        tempCoins.append(coin3)
        tempCoins.append(coin4)
        tempCoins.append(coin5)
        
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
    
        cell.progressLabel.textColor = Colors.iconContrastYellow
        cell.coinLabel.textColor = Colors.iconContrastYellow 
        
        cell.backgroundColor = UIColor.clear
//      cell.setGradientBackground(oneColor: UIColor.black, twoColor: UIColor.blue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifiers[indexPath.row], sender: self)    }
 

}

