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

}
