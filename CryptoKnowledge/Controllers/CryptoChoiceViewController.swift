//
//  CryptoChoiceViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/29/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import UIKit
import Firebase


class CryptoChoiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var coins: [Coins] = []
    var segueIdentifiers = ["cryptoquiz","bitcoin","ethereum"]
    let navItem = UINavigationItem()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @objc func goBackToLogin() {
        
    
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? UIViewController else {
                return
            }
            present(mainRegistrationVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CryptoKnowledge"
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(goBackToLogin))
        
        tableView.reloadData()
        coins = createArray()
        tableView.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        tableView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.reloadData()
        
    }
    

    func createArray() -> [Coins] {
        
        
        var tempCoins: [Coins] = []
        
        let coin1 = Coins(image: UIImage(named: "cryptoquiz coin")!, name: "Crypto Quiz", progress: "1", controller: "CryptoViewController")
        let coin2 = Coins(image: UIImage(named: "bitcoin")!, name: "Bitcoin", progress: "2", controller: "BtcViewController")
        let coin3 = Coins(image: UIImage(named: "Ethereum")!, name: "Ethereum", progress: "3", controller: "EthereumViewController")
//        let coin4 = Coins(image: UIImage(named: "ripple")!, name: "Ripple", controller: "RippleViewContro )
//        let coin5 = Coins(image: UIImage(named: "litecoin")!, name: "Litcoin")
       
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("Users").child(uid!).child("Question Number").observeSingleEvent(of: .value, with: {(snap) in
            print(snap)
            if let snapDict = snap.value as? NSDictionary{
                let progress = snapDict["Question Number"]
                print(progress)
            }
        })

        tempCoins.append(coin1)
        tempCoins.append(coin2)
        tempCoins.append(coin3)
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
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifiers[indexPath.row], sender: self)    }
 

}




