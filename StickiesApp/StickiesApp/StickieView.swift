//
//  StickieView.swift
//  StickiesApp
//
//  Created by Ganesh on 06/04/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import Foundation
import UIKit

protocol StickieViewDelegate
{
    func didComeFront(view: StickieView)
}

class StickieView: UIView, UITextViewDelegate {
    
    var isSelected = false
        {
        willSet(newValue)
        {
            if newValue == true
            {
                self.layer.borderColor = STICKIE_BORDER_COLOR_SELECTED.CGColor
                aTextView.textColor = UIColor.grayColor()
            }
            else
            {
                self.layer.borderColor = STICKIE_BORDER_COLOR.CGColor
                aTextView.textColor = UIColor.grayColor()
            }
        }
    }
    var aTextView: UITextView = UITextView()
    var isEditing = false
        {
        
        willSet(newValue)
        {
            if newValue == true
            {
                self.layer.borderColor = STICKIE_BORDER_COLOR_SELECTED.CGColor
                aTextView.textColor = UIColor.darkGrayColor()
            }
            else
            {
                self.layer.borderColor = STICKIE_BORDER_COLOR.CGColor
                aTextView.textColor = UIColor.grayColor()
            }
        }
    }
    var delegate: StickieViewDelegate?
    var thisPosition: CGPoint = CGPointZero
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.isSelected = false
        let text = aDecoder.decodeObjectForKey("viewText") as? String
        let xPos = aDecoder.decodeObjectForKey("centerX") as? CGFloat
        let yPos = aDecoder.decodeObjectForKey("centerY") as? CGFloat
        
        if let _ = xPos, let _ = yPos
        {
            self.center = CGPointMake(xPos!+10.0, yPos!+10.0)
            thisPosition = self.center
        }
        aTextView.text = text
    }
    
    init()
    {
        super.init(frame: CGRectMake(0, 0, CGFloat(STICKIE_WIDTH), CGFloat(STICKIE_HEIGHT)))
        self.layer.cornerRadius = CGFloat(STICKIE_CORNER)
        self.layer.borderWidth = CGFloat(STICKIE_BORDER_WIDTH)
        self.layer.borderColor = STICKIE_BORDER_COLOR.CGColor
        self.backgroundColor = STICKIE_BACKGROUND_COLOR
        aTextView.frame = self.bounds
        aTextView.delegate = self
        aTextView.backgroundColor = UIColor.clearColor()
        aTextView.userInteractionEnabled = isEditing
        aTextView.font = UIFont(name: "ChalkboardSE-Regular", size: 12)
        aTextView.textColor = UIColor.darkGrayColor()
        aTextView.spellCheckingType = .No
        self.addSubview(aTextView)
    }
    
    override func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(aTextView.text, forKey: "viewText")
        coder.encodeObject(thisPosition.x, forKey: "centerX")
        coder.encodeObject(thisPosition.y, forKey: "centerY")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        isEditing = true
        self.superview?.bringSubviewToFront(self)
        delegate?.didComeFront(self)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        isEditing = false
        let touch = touches.first
        let location = touch!.locationInView(self.superview)
        let oldLocation = touch!.previousLocationInView(self.superview)
        self.frame = CGRectOffset(self.frame, location.x-oldLocation.x, location.y-oldLocation.y)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

        thisPosition = self.center
        aTextView.userInteractionEnabled = isEditing
        if isEditing == true
        {
            aTextView.becomeFirstResponder()
            isEditing = true
            self.superview?.bringSubviewToFront(self)
            delegate?.didComeFront(self)
            self.layer.borderColor = STICKIE_BORDER_COLOR_EDITING.CGColor
        }
        else
        {
            aTextView.resignFirstResponder()
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        isEditing = true
        self.superview?.bringSubviewToFront(self)
        delegate?.didComeFront(self)
        self.layer.borderColor = STICKIE_BORDER_COLOR_EDITING.CGColor
        let shouldY = CGFloat(GENERAL_KEYBOARD_HEIGHT) + (self.frame.size.width/2)
        let centerY = self.center.y
        if shouldY < centerY
        {
            
            UIView.animateWithDuration(Double(0.3), animations: {
                self.center = CGPointMake(self.center.x,  shouldY)
            })
            
        }
        
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
        textView.userInteractionEnabled = false
        isEditing = false
        self.layer.borderColor = STICKIE_BORDER_COLOR.CGColor
    }
    
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(CGImage: image.CGImage!)
    }
}

/*
 //Dead code : Just for checking
 extension StickieView
 {
 func copyView() -> StickieView
 {
 return NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(self)) as! StickieView
 }
 }
 
 */
