//
//  SelectionView.swift
//  StickiesApp
//
//  Created by Ganesh on 4/5/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import UIKit

class SelectionView: UIView {

    static let sharedInstace = SelectionView()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init()
    {
        super.init(frame: CGRectMake(0, 0, 2, 2))
        self.layer.cornerRadius = CGFloat(2.0)
        self.layer.borderWidth = CGFloat(1.0)
        self.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.backgroundColor = UIColor.clearColor()
    }

}
