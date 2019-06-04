//
//  animations.swift
//  CryptoKnowledge
//
//  Created by Timothy Kruger on 11/29/18.
//  Copyright © 2018 Timothy Kruger. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func pushTransitionLeft(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromLeft
        animation.duration = 1
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
    
    func pushTransitionRight(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.reveal
        animation.subtype = CATransitionSubtype.fromRight
        animation.duration = 1
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
    func pushTransitionRightSlow(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.reveal
        animation.subtype = CATransitionSubtype.fromRight
        animation.duration = 3
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
    
    func pushTransitionBottom(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeIn)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromBottom
        animation.duration = 1
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
    func pushTransitionTop(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        animation.duration = 1
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
}
