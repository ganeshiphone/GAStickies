//
//  StickieView.swift
//  StickiesApp
//
//  Created by Ganesh on 05/04/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import Foundation
import UIKit

class StickieView: UIView, UITextViewDelegate {
    
    var isSelected = false
        {
        willSet(newValue)
        {
            if newValue == true
            {
                self.layer.borderColor = STICKIE_BORDER_COLOR_SELECTED.CGColor
            }
            else
            {
                self.layer.borderColor = STICKIE_BORDER_COLOR.CGColor
            }
        }
    }
    var aTextView: UITextView = UITextView()
    var isEditing = false
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.isSelected = false
        let text = aDecoder.decodeObjectForKey("viewText") as? String
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
        self.addSubview(aTextView)
    }
    
    override func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(aTextView.text, forKey: "viewText")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesBegan")
        isEditing = true
        self.superview?.bringSubviewToFront(self)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesMoved")
        isEditing = false
        let touch = touches.first
        let location = touch!.locationInView(self.superview)
        let oldLocation = touch!.previousLocationInView(self.superview)
        self.frame = CGRectOffset(self.frame, location.x-oldLocation.x, location.y-oldLocation.y)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesEnded")
        aTextView.userInteractionEnabled = isEditing
        if isEditing == true
        {
            aTextView.becomeFirstResponder()
            isEditing = true
            self.superview?.bringSubviewToFront(self)
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
        self.layer.borderColor = STICKIE_BORDER_COLOR_EDITING.CGColor
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
        textView.userInteractionEnabled = false
        isEditing = false
        self.layer.borderColor = STICKIE_BORDER_COLOR.CGColor
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
