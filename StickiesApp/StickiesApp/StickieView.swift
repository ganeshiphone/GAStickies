//
//  StickieView.swift
//  StickiesApp
//
//  Created by Ganesh on 05/04/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import Foundation
import UIKit

class StickieView: UIView {
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init()
    {
        super.init(frame: CGRectMake(0, 0, CGFloat(STICKIE_WIDTH), CGFloat(STICKIE_HEIGHT)))
        self.layer.cornerRadius = CGFloat(STICKIE_CORNER)
        self.layer.borderWidth = CGFloat(STICKIE_BORDER_WIDTH)
        self.layer.borderColor = STICKIE_BORDER_COLOR.CGColor
        self.backgroundColor = STICKIE_BACKGROUND_COLOR
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesBegan")
        self.superview?.bringSubviewToFront(self)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesMoved")
        let touch = touches.first
        let location = touch!.locationInView(self.superview)
        let oldLocation = touch!.previousLocationInView(self.superview)
        self.frame = CGRectOffset(self.frame, location.x-oldLocation.x, location.y-oldLocation.y)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesEnded")
    }
}
