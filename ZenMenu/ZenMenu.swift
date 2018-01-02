//
//  ZenMenu.swift
//  ZenBanana Co.
//
//  Created by Tanner Juby on 9/8/17.
//  Copyright © 2017 com.zenbanana. All rights reserved.
//

import Foundation
import UIKit


// MARK: - ZenMenu
open class ZenMenu: UIButton {
    
    // Type
    public enum MenuType {
        case fullCircle
        case halfCircle
        case quarterCircle
    }
    
    // Direction Enum
    public enum Direction {
        case north
        case south
        case east
        case west
    }

    // MARK: Variables
    
    /// Delegate for HalfCircleMenu
    weak open var delegate: ZenMenuDelegate?
    
    /// Parent View
    open var parentView: UIView!
    
    /// Cover View
    private var coverView: UIView!
    open var willDimBackground = true
    open var dimColor: UIColor = UIColor.black
    open var dimAlpha: CGFloat = 0.8
    
    /// Animation Duration
    @IBInspectable open var animationDuration: Double = 0.3
    /// Radius
    @IBInspectable open var radius: Double = 100
    /// Image for when menu is closed and can be opened
    @IBInspectable var openMenuIcon: UIImage?
    /// Image for when menu is open and can be closed
    @IBInspectable var closeMenuIcon: UIImage?
    
    /// CircleType
    open var type: MenuType = .halfCircle
    /// Direction
    open var direction: Direction = .north
    /// Menu Items
    open var items: [ZenMenuItem]?
    /// ImageView for any image on the
    open var menuIcon: UIImageView!
    
    /// Boolean for if the menu is currently opened or closed
    open var isOpen = false
    /// Boolean for if the menu items have been prepared
    private var itemsPrepared = false
    
    // MARK: Initializers
    
    /**
     Initializes and Returns a Zen Menu Object
     
     - parameter frame:             A CGRect specifying the size and location of the HalfCircleMenuView
     - parameter parentView:        The parent view of where the ZenMenu will be located
     - parameter openMenuImage:     The image that will be set when the menu is closed and can be opened
     - parameter closeMenuImage:    The image that will be set when the menu is open and can be closed
     - parameter itemCount:         The number of items in the menu
     - parameter animationDuration: The length of time, in seconds, of the animation to open and close the menu
     - parameter radius:            The distance between the center of the HalfCircleMenu and the centers of the HalfCircleMenuItems when they are open
     */
    public init(frame: CGRect, parentView: UIView, openMenuIcon: UIImage?, closeMenuIcon: UIImage?, menuItems: [ZenMenuItem], menuType: MenuType, direction: Direction, animationDuration: Double = 0.3, radius: Double = 100) {
        super.init(frame: frame)
        
        self.parentView = parentView
        self.openMenuIcon = openMenuIcon
        self.closeMenuIcon = closeMenuIcon
        self.items = menuItems
        self.type = menuType
        self.direction = direction
        self.animationDuration = animationDuration
        self.radius = radius
    }
    
    /**
     Initializes the ZenMenu features.
    */
    public func commonInit() {
        
        if self.openMenuIcon != nil {
            setImage(openMenuIcon, for: .normal)
        }
        
        // Limit the number of items depending on menu type
        if let itemCount = items?.count {
            switch self.type {
            case .fullCircle:
                if itemCount > 16 {
                    let tempItems: [ZenMenuItem] = Array(items!.prefix(upTo: 16))
                    items = tempItems
                }
                
            case .halfCircle:
                if itemCount > 8 {
                    let tempItems: [ZenMenuItem] = Array(items!.prefix(upTo: 8))
                    items = tempItems
                }
                
            case .quarterCircle:
                if itemCount > 4 {
                    let tempItems: [ZenMenuItem] = Array(items!.prefix(upTo: 4))
                    items = tempItems
                }
            }
        }
        
        
        // Set up internal workings
        coverView = UIView(frame: parentView.frame)
        coverView.backgroundColor = dimColor
        self.coverView.isUserInteractionEnabled = true
        coverView.alpha = 0.0
        self.coverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.close)))
        parentView.insertSubview(coverView, at: 0)
        
        parentView.bringSubview(toFront: coverView)
        parentView.bringSubview(toFront: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: Private Class Functions
 
    /**
     Prepare Menu Items
     
     Prepare the menu items
     */
    fileprivate func prepareMenuItems() {
        
        let centerPoints: [CGPoint] = calculateCenterPoints()
        
        let tempFrame = self.parentView.convert(self.frame, from: self.superview)
        
        // Loop through the items and set their locations for when menu is open
        for i in 0 ..< items!.count {
            
            // Call willPrepareZenMenuItem protocol
            self.delegate?.zenMenu?(self, willPrepareZenMenuItem: items![i], index: i)
            
            let originalFrame = items![i].frame
            
            // Set item's frame for when menu is closed
            items![i].closedFrame = tempFrame
            items![i].frame = tempFrame
            
            // Set item's frame for when menu is open
            let x = centerPoints[i].x - (originalFrame.width / 2)
            let y = centerPoints[i].y - (originalFrame.height / 2)
            items![i].openedFrame = CGRect(x: x, y: y, width: originalFrame.width, height: originalFrame.height)
            
            // Add actions for Menu Item
            let itemTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.zenItemSelected(_:)))
            items![i].addGestureRecognizer(itemTapGesture)
            items![i].tag = i
            
            // Hide the item
            items![i].alpha = 0.0
            
            // Call didPrepareZenMenuItem protocol
            self.delegate?.zenMenu?(self, didPrepareZenMenuItem: items![i], index: i)
            
            // Add Item to parent view, below the ZenMenu button
            self.parentView?.insertSubview(items![i], belowSubview: self)
        }
        
        itemsPrepared = true
    }
    
    /**
     Calculate Center Points
     
     Calculates the center points for the ZenMenuItems
     */
    fileprivate func calculateCenterPoints() -> [CGPoint] {
        
        var centerPoints: [CGPoint] = []
        
        // Divisor to determine angles from the MenuButton to calculate positioning for
        let divisor : Int = (self.items?.count)!
        
        // Starting angle for the center point of the first item
        var initialAngle : Double = 0.0
        
        // Set the initial angle based on the direction of menu
        switch self.direction {
        case .east:
            initialAngle = 0.0
        case .south:
            initialAngle = 90.0
        case .west:
            initialAngle = 180.0
        case .north:
            initialAngle = 270.0
        }
        
        // Interval to increase the calculating angle by for each item
        var angleInterval: Double = 0.0
        
        // Set the angle interval based on the divisor
        switch self.type {
        case .quarterCircle:
            angleInterval = Double(90.0 / Double(divisor-1))
            
        case .halfCircle:
            angleInterval = Double(180.0 / Double(divisor+1))
            initialAngle += angleInterval
            
        case .fullCircle:
            angleInterval = Double(360.0 / Double(divisor))
        }
        
        // Get the ZenMenu buttons frame based on the parent view
        let tempFrame = self.parentView.convert(self.frame, from: self.superview)
        
        // Loop through each item and set its center point when its open
        for i in 0 ..< divisor {
            // Angle of the current item
            let angle: Double = initialAngle + (angleInterval * Double(i))
            
            // Calcualate the center points of the current menu item
            let tempX = Double(tempFrame.midX) + (self.radius * cos(angle * Double.pi / 180))
            let tempY = Double(tempFrame.midY) + (self.radius * sin(angle * Double.pi / 180))
            
            let tempPoint = CGPoint(x: tempX, y: tempY)
            
            // Add the point to the array being returnd
            centerPoints.append(tempPoint)
        }
        
        // Return the center points
        return centerPoints
    }
    
    /**
     Item Selected
     
     Triggers the event of a ZenMenuItem being selected
     */
    @objc fileprivate func zenItemSelected(_ sender: UITapGestureRecognizer) {
        
        guard let menuItem = sender.view as? ZenMenuItem else {
            return
        }
        
        // Activate the willSelectZenItem protocol
        self.delegate?.zenMenu?(self, willSelectZenMenuItem: menuItem, index: menuItem.tag)
        
        // Make the selection
        DispatchQueue.main.asyncAfter(deadline: .now()/* + animationDuration*/, execute: {
            // Activate the didSelectZenItem protocol
            self.delegate?.zenMenu?(self, didSelectZenMenuItem: menuItem, index: menuItem.tag)
        })
        
        // Close the menu
        self.close()
    }
    
    
    
    // MARK: Open Class Functions
    
    open func toggle() {
        if isOpen {
            close()
        } else {
            open()
        }
    }
    
    /**
     Open Menu
     
     Opens the menu from the closed state
     */
    open func open() {
        
        if !itemsPrepared {
            prepareMenuItems()
        }
        
        // Activate the willOpen protocol
        self.delegate?.willOpen?(self)
        
        self.zenMenuSpinClockwise(duration: animationDuration)
        
        UIView.animate(withDuration: animationDuration, animations: {
            // Move the ZenMenu's items to their opened positions
            
            for i in 0 ..< self.items!.count {
                self.items![i].frame = self.items![i].openedFrame
                self.delegate?.zenMenu?(self, willPresentZenMenuItem: self.items![i], index: i)
                self.items![i].alpha = 1.0
            }
            
            if self.willDimBackground {
                self.coverView.alpha = self.dimAlpha
            }
            
            if self.closeMenuIcon != nil {
                self.setImage(self.closeMenuIcon, for: .normal)
            }
            
        }, completion: { _ in
            
            for i in 0 ..< self.items!.count {
                self.delegate?.zenMenu?(self, didPresentZenMenuItem: self.items![i], index: i)
            }
            // Activate the didOpen protocol
            self.delegate?.didOpen?(self)
            self.isOpen = true
            
        })
    }
    
    /**
     Close Menu
 
     Closes the menu from the opened state
     */
    @objc open func close() {
        
        // Activate the willClose protocol
        self.delegate?.willClose?(self)
        
        self.zenMenuSpinCounterClockwise(duration: animationDuration)
        
        UIView.animate(withDuration: animationDuration, animations: {
            // Move the ZenMenu's items to their closed positions
            for i in 0 ..< self.items!.count {
                self.items![i].frame = self.items![i].closedFrame
                self.delegate?.zenMenu?(self, willDismissZenMenuItem: self.items![i], index: i)
                self.items![i].alpha = 0.0
            }
            
            if self.willDimBackground {
                self.coverView.alpha = 0.0
            }
            
            if self.openMenuIcon != nil {
                self.setImage(self.openMenuIcon, for: .normal)
            }
            
        }, completion: { _ in
            
            for i in 0 ..< self.items!.count {
                self.delegate?.zenMenu?(self, didDismissZenMenuItem: self.items![i], index: i)
            }
            
            // Activate the didClose protocol
            self.delegate?.didClose?(self)
            self.isOpen = false
        })
    }
    
    
    // MARK: Override Actions
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        sendActions(for: .touchUpInside)
        super.touchesEnded(touches, with: event)
    }
    
    override open func sendActions(for controlEvents: UIControlEvents) {
        if controlEvents == .touchUpInside {
            toggle()
        }
    }
    
}

// MARK: - ZenMenUDelegate
@objc public protocol ZenMenuDelegate {
    
    /**
     Tells the delegate the Menu will open
     
     parameter zenMenu: - A ZenMenu object informing the delegate the menu will begin to open
     */
    @objc optional func willOpen(_ zenMenu: ZenMenu)
    
    /**
     Tells the delegate the Menu did open
     
     parameter zenMenu: - A ZenMenu object informing the delegate the menu did finish opening
     */
    @objc optional func didOpen(_ zenMenu: ZenMenu)
    
    /**
     Tells the delegate the Menu will prepare the menu items
     
     parameter zenMenu:     - A ZenMenu object informing the delegate about a ZenMenuItem being prepared
     parameter zenMenuItem: - The ZenMenuItem object that was prepared
     parameter index:       - The index of where the ZenMenuItem is located in the ZenMenu's items array
     */
    @objc optional func zenMenu(_ zenMenu: ZenMenu, willPrepareZenMenuItem zenMenuItem: ZenMenuItem, index: Int)
    
    /**
     Tells the delegate the Menu did prepare the menu items
     
     parameter zenMenu:     - A ZenMenu object informing the delegate about a ZenMenuItem being prepared
     parameter zenMenuItem: - The ZenMenuItem object that was prepared
     parameter index:       - The index of where the ZenMenuItem is located in the ZenMenu's items array
     */
    @objc optional func zenMenu(_ zenMenu: ZenMenu, didPrepareZenMenuItem zenMenuItem: ZenMenuItem, index: Int)
    
    /**
     Tells the delegate the Menu will present a ZenMenuItem Object
     
     parameter zenMenu:     - A ZenMenu object informing the delegate about presenting a ZenMenuItem
     parameter zenMenuItem: - The ZenMenuItem object that will be presented
     parameter index:       - The index of where the ZenMenuItem is located in the ZenMenu's items array
     */
    @objc optional func zenMenu(_ zenMenu: ZenMenu, willPresentZenMenuItem zenMenuItem: ZenMenuItem, index: Int)
    
    /**
     Tells the delegate the Menu did present a ZenMenuItem Object
     
     parameter zenMenu:     - A ZenMenu object informing the delegate about a ZenMenuItem being presented
     parameter zenMenuItem: - The ZenMenuItem object that was presented
     parameter index:       - The index of where the ZenMenuItem is located in the ZenMenu's items array
     */
    @objc optional func zenMenu(_ zenMenu: ZenMenu, didPresentZenMenuItem zenMenuItem: ZenMenuItem, index: Int)
    
    /**
     Tells the delegate the Menu will dismiss a ZenMenuItem Object
     
     parameter zenMenu:     - A ZenMenu object informing the delegate about dismissing a ZenMenuItem
     parameter zenMenuItem: - The ZenMenuItem object that will be dismissed
     parameter index:       - The index of where the ZenMenuItem is located in the ZenMenu's items array
     */
    @objc optional func zenMenu(_ zenMenu: ZenMenu, willDismissZenMenuItem zenMenuItem: ZenMenuItem, index: Int)
    
    /**
     Tells the delegate the Menu did dismiss a ZenMenuItem Object
     
     parameter zenMenu:     - A ZenMenu object informing the delegate about a ZenMenuItem being dismissed
     parameter zenMenuItem: - The ZenMenuItem object that was dismissed
     parameter index:       - The index of where the ZenMenuItem is located in the ZenMenu's items array
     */
    @objc optional func zenMenu(_ zenMenu: ZenMenu, didDismissZenMenuItem zenMenuItem: ZenMenuItem, index: Int)
    
    /**
     Tells the delegate the Menu will select a ZenMenuItem Object
     
     parameter zenMenu:     - A ZenMenu object informing the delegate about selecting a ZenMenuItem
     parameter zenMenuItem: - The ZenMenuItem object that will be selected
     parameter index:       - The index of where the ZenMenuItem is located in the ZenMenu's items array
     */
    @objc optional func zenMenu(_ zenMenu: ZenMenu, willSelectZenMenuItem zenMenuItem: ZenMenuItem, index: Int)
    
    /**
     Tells the delegate the Menu did select a ZenMenuItem Object
     
     parameter zenMenu:     - A ZenMenu object informing the delegate about a ZenMenuItem being selected
     parameter zenMenuItem: - The ZenMenuItem object that was selected
     parameter index:       - The index of where the ZenMenuItem is located in the ZenMenu's items array
     */
    @objc optional func zenMenu(_ zenMenu: ZenMenu, didSelectZenMenuItem zenMenuItem: ZenMenuItem, index: Int)
    
    /**
     Tells the delegate the Menu will close
     
     parameter zenMenu: - A ZenMenu object informing the delegate the menu will begin to close
     */
    @objc optional func willClose(_ zenMenu: ZenMenu)
    
    /**
     Tells the delegate the Menu did close
     
     parameter zenMenu: - A ZenMenu object informing the delegate the menu did finish closing
     */
    @objc optional func didClose(_ zenMenu: ZenMenu)
    
}
