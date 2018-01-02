//
//  ZenMenuHelper.swift
//  safe-ios
//
//  Created by Tanner Juby on 9/11/17.
//  Copyright © 2017 com.zenbanana. All rights reserved.
//

import Foundation
import UIKit


/**
 UIView Extension
 
 Extension block for custom functions on UIViews
*/
public extension UIView {
    
    /**
     Round Corners
     
     Makes the corners rounded
     */
    func roundCorners(withRadius: CGFloat) {
        self.layer.cornerRadius = withRadius
        self.layer.masksToBounds = true
    }
    
    /**
     Make Circle
     
     Makes the view a circle
     */
     func makeCircle() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.masksToBounds = true
    }
    
    /**
     Zen Menu Spin Clockwise
     
     Spins a UIView Clockwise one time around
     */
    func zenMenuSpinClockwise(duration: CFTimeInterval, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as? CAAnimationDelegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    /**
     Zen Menu Spin Counter Clockwise
     
     Spins a UIView Counter Clockwise one time around
     */
    func zenMenuSpinCounterClockwise(duration: CFTimeInterval, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.toValue = 0.0
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as? CAAnimationDelegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
