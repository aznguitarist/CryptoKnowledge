//
//  NavBarGradient.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 11/29/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit
class GradientButton : UIButton {
    
    var leftColor = UIColor.red
    var rightColor = UIColor.green
    var customImage : UIImage? {
        didSet {
            updateImageView()
        }
    }
    let gradientLayer = CAGradientLayer()
    let customImageView = UIImageView()
    
    override var frame: CGRect {
        didSet {
            gradientLayer.frame = bounds
            layer.layoutIfNeeded()
        }
    }
    
    convenience init(leftColor: UIColor, rightColor: UIColor, image: UIImage) {
        self.init()
        
        self.leftColor = leftColor
        self.rightColor = rightColor
        customImage = image
        updateImageView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        defaultInitializer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        defaultInitializer()
    }
    
    func defaultInitializer() {
        
        gradientLayer.frame = bounds
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
        layer.layoutIfNeeded()
        
        addSubview(customImageView)
        customImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func updateImageView() {
        customImageView.image = customImage
        customImageView.alpha = 0.2
        layoutSubviews()
    }
}
