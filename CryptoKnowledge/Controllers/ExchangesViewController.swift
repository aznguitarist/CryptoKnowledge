//
//  ExchangesViewController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 12/10/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

class ExchangesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct Exchanges {
        var exchangeCategory: String!
        var exchanges: [String]!
        var links: [String]!
    }
    
    var exchangeList = [Exchanges]()
    
    
    var cellID = "cellID"
    
    
    // TODO: View Setup
    let navBarView: UIView = {
        let navBar = UIView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.layer.masksToBounds = true
        return navBar
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("< Back", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.text = "Exchanges" 
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.masksToBounds = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
//        tableView.delegate = self
//        tableView.dataSource = self
        return tableView
    }()
    
   
    override func viewDidLoad(){
        super.viewDidLoad()
        exchangeList = [
            Exchanges(exchangeCategory: "Crypto Only", exchanges: ["Binance","Bitfinex", "Bitmex"], links: ["https://www.binance.com/en","https://www.bitfinex.com/","https://www.bitmex.com/"]),
            Exchanges(exchangeCategory: "United States", exchanges: ["Coinbase", "Gemini", "itBit",], links: ["https://www.coinbase.com/","https://gemini.com/", "https://www.itbit.com/"]), Exchanges(exchangeCategory: "Europe", exchanges: ["Bitstamp","CEX.io", "Coinbase"], links: ["https://www.bitstamp.net/","https://cex.io/", "https://www.coinbase.com"]), Exchanges(exchangeCategory: "South Korea", exchanges: ["Korbit", "Bithumb", "Upbit", "Coinplug", "Coinone"], links: ["https://www.korbit.co.kr/","https://www.bithumb.com/","https://sg.upbit.com/home","https://www.coinplug.com/","https://coinone.co.kr/"])
        ]
            
        view.addSubview(navBarView)
        view.addSubview(tableView)
        view.backgroundColor = UIColor.black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.reloadData()
        setNavigationBar()
        setTableView() 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let navGradient = CAGradientLayer()
        navGradient.frame = navBarView.frame
        navGradient.colors = [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
        //        navGradient.locations = [0.66, 0.33]
        navGradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        navGradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        view.layer.insertSublayer(navGradient, at: 0)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return exchangeList[section].exchanges.count
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return exchangeList.count
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return exchangeList[section].exchangeCategory
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.darkGray 
        label.text = exchangeList[section].exchangeCategory
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.font = label.font.withSize(30)
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellID")
//        cell.textLabel?.text = exchangeList[indexPath.section].exchanges[indexPath.row]
        cell.textLabel?.text = exchangeList[indexPath.section].exchanges[indexPath.row] 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlArray = self.exchangeList[indexPath.section].links[indexPath.row]
        if let url = URL(string: urlArray)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil) 
        }
        
        
        return print(exchangeList[indexPath.row])
    }
  
    
    @objc func back() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainRegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "FirstMainNavigationController")
        present(mainRegistrationVC, animated: true, completion: nil)
    }
    
    
    func setNavigationBar() {
        
        navBarView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        navBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navBarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navBarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        navBarView.addSubview(backButton)
        navBarView.addSubview(titleLabel)
        
        backButton.leftAnchor.constraint(equalTo: navBarView.leftAnchor).isActive = true
        backButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor, constant: 10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 64).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor, constant: 10).isActive = true
        view.addSubview(navBarView)
    }
    
    func setTableView(){
        tableView.topAnchor.constraint(equalTo: navBarView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}


fileprivate extension UIImage {
    static func gradientImage(with bounds: CGRect,
                              colors: [CGColor],
                              locations: [NSNumber]?) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 1.0,
                                           y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0,
                                         y: 1.0)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}
