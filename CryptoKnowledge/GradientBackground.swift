//
//  GradientBackground.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 10/26/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBack(oneColor: UIColor, twoColor: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [oneColor.cgColor, twoColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackground(oneColor: UIColor, twoColor: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [oneColor.cgColor, twoColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackground2(oneColor: UIColor, twoColor: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds

        gradientLayer.colors = [oneColor.cgColor, twoColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = gradientLayer.bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func setGradientBackground3(oneColor: UIColor, twoColor: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.colors = [oneColor.cgColor, twoColor.cgColor]
        gradientLayer.locations = [0.0, 1.0, 0.5]
        gradientLayer.startPoint = CGPoint(x: 0.1, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = gradientLayer.bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackground4(oneColor: UIColor, twoColor: UIColor, threeColor: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.colors = [oneColor.cgColor, twoColor.cgColor, threeColor.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.frame = gradientLayer.bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackground5(oneColor: UIColor, twoColor: UIColor, threeColor: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.colors = [oneColor.cgColor, twoColor.cgColor, threeColor.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = gradientLayer.bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func setGradientBackgroundspeical(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.colors = [UIColor.darkGray.cgColor, Colors.moneroOrange.cgColor,  UIColor.darkGray.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
       
        layer.insertSublayer(gradientLayer, at: 0)
}

    func gradient(){
        
    }
    
}
