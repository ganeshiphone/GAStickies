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
    let shapeLayer:CAShapeLayer = CAShapeLayer()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init()
    {
        super.init(frame: CGRectMake(0, 0, 2, 2))
        self.backgroundColor = UIColor.clearColor()
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [7,15]
        self.layer.addSublayer(shapeLayer)
    }
    
    override func layoutSubviews() {
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).CGPath
    }
    
}
