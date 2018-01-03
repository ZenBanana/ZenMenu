//
//  ZenMenuItem.swift
//  ZenBanana Co.
//
//  Created by Tanner Juby on 9/8/17.
//  Copyright © 2017 com.zenbanana. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ZenMenuItem

open class ZenMenuItem: UIView {
    
    // MARK: Variables
    
    /// Frame of the menu item when the menu is closed
    var closedFrame: CGRect!
    /// Frame of the menu item when the menu is open
    var openedFrame: CGRect!
    
    // MARK: Initializers
    
    /**
     Initializes and Returns a ZenMenuItem object that only has a title
     
     parameter frame:           The frame of the item
     parameter title:           The title of the item
     parameter backgroundColor: The color of the background of the item
     */
    public init(title: String, withSize: CGSize, backgroundColor: UIColor, titleColor: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: withSize.width, height: withSize.height))
        
        let titleLabel = UILabel()
        titleLabel.frame = bounds
        
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = backgroundColor
        titleLabel.textColor = titleColor
        titleLabel.adjustsFontSizeToFitWidth = true
        
        self.addSubview(titleLabel)
    }
    
    /**
     Initializes and Returns a ZenMenuItem object that only has asn image
     
     parameter frame:           The frame of the item
     parameter icon:            The image for the item
     parameter backgroundColor: The color of the background of the item
     */
    public init(icon: UIImage, withSize: CGSize) {
        super.init(frame:CGRect(x: 0, y: 0, width: withSize.width, height: withSize.height))
        
        let iconImage = UIImageView(image: icon)
        iconImage.frame = bounds
        
        self.addSubview(iconImage)
    }
    
    /**
     Initializes and Returns a ZenMenuItem object that has a custom view
     
     parameter frame:           The frame of the item
     parameter icon:            The image for the item
     parameter backgroundColor: The color of the background of the item
     */
    public init(customItemView: UIView, withSize: CGSize) {
        super.init(frame: CGRect(x: 0, y: 0, width: withSize.width, height: withSize.height))
        
        // Add custom view to the ZenMenuItem's custom view
        customItemView.frame = self.bounds
        
        self.addSubview(customItemView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
