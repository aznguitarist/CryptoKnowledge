//
//  AddCoinToMarketVeiwController.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 12/31/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//
import UIKit
import Dispatch

struct ListData: Decodable {
    var id : String?
    var symbol : String?
    var name : String?
}

class AddCoinToMarketViewController: UIViewController {
    var list = [String]()
    
    //TODO: Buttons
    let textBar: UITextField = {
    var textfield = UITextField()
        textfield.backgroundColor = UIColor.gray
        textfield.layer.cornerRadius = 10
        textfield.placeholder = "  Enter Ticker Symbol"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.layer.masksToBounds = true
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.addTarget(self, action: "choice", for: .touchUpInside)
    return textfield
    }()
    
    let showView: UILabel = {
        var label = UILabel()
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.gray
        label.layer.cornerRadius = 10 
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.adjustsFontSizeToFitWidth = true
        
    return label
    }()
    
    let enterButton: UIButton = {
        var button = UIButton()
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.darkGray
        button.setTitle("Enter", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(AddCoinToMarketViewController.choice), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.black
//        view.addSubview(backButton)
        view.addSubview(textBar)
        view.addSubview(showView)
        view.addSubview(enterButton)
      
        viewLayout()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func viewLayout(){
//
//        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
//        backButton.topAnchor.constraint(equalTo:view.topAnchor, constant: 30).isActive = true
//        backButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
//        backButton.widthAnchor.constraint(equalToConstant: 100).isActive = true

        textBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textBar.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        showView.bottomAnchor.constraint(equalTo: textBar.topAnchor, constant: -10).isActive = true
        showView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        showView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        showView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        enterButton.topAnchor.constraint(equalTo: textBar.bottomAnchor, constant: 10).isActive = true
        enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        enterButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        enterButton.widthAnchor.constraint(equalToConstant: 150).isActive = true

        view.addSubview(enterButton)
       view.addSubview(textBar)
       view.addSubview(showView)
}
    
    func coinRequest() {
       
        
        let requestURL = URL(string: "https://api.coingecko.com/api/v3/coins/list")!
        
        let task = URLSession.shared.dataTask(with: requestURL)
        {
            (data: Data?, response: URLResponse?, error: Error?) in
            if (error != nil){
                print("Error: \(String(describing: error))")
            } else {
                
                do {
                    let json = try JSONDecoder().decode([ListData].self, from: data!)

                    for coin in json {
                        self.list.append(coin.symbol ?? "none")
//                  self.list.append(json[0])
//                    self.list.append(json[1])
//                    print(self.list)
//                    DispatchQueue.main.async {
//                        self.showView.text = self.list[0].name
                    print(self.list)
                    }
                  
                }catch{
                    print("Error")
                }
                
            }
            }
        task.resume()
     
    }
    
    @objc func back(){
     performSegue(withIdentifier: "AddCoin", sender: self)
    }
    
    @objc func choice(){
        showView.text = textBar.text 
        print(showView.text ?? "none")
        print(list)
    }
} 
