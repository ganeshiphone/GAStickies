//
//  ViewController.swift
//  StickiesApp
//
//  Created by Ganesh on 05/04/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import UIKit

class StickieStack
{
    var items:[StickieView] = []
    func push(item: StickieView)
    {
        items.insert(item, atIndex: 0)
    }
    func pop()
    {
        if items.count > 0
        {
            items.removeFirst()
        }
    }
    func currentStickie() -> StickieView?
    {
        if items.count > 0
        {
            return items[0]
        }
        return nil
    }
}

class ViewController: UIViewController {

    var stickieStack = StickieStack()
    var selectionView : SelectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newButtonTapped(sender: UIBarButtonItem)
    {
        addNewStickieView()
    }
    
    
    func addNewStickieView()
    {
        let stickieView = StickieView()
        self.view.addSubview(stickieView)
        if let previousView = stickieStack.currentStickie()
        {
            stickieView.center = CGPointMake(previousView.center.x+5.0, previousView.center.y+5.0)
        }
        else
        {
            stickieView.center = self.view.center
        }
        
        stickieStack.push(stickieView)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesBegan")
        selectionView?.removeFromSuperview()
        selectionView = SelectionView()
         self.view.addSubview(selectionView!)
        
        let touch = touches.first
        let location = touch!.locationInView(self.view)
        selectionView!.frame = CGRect(origin: location, size: selectionView!.frame.size)
        
        
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesMoved")
        
        let touch = touches.first
        let location = touch!.locationInView(self.view)
        let oldLocation = selectionView!.frame.origin
        let thisSize: CGSize?
        if (location.x - oldLocation.x) > 0 && (location.y - oldLocation.y) > 0
        {
            thisSize = CGSizeMake(location.x - oldLocation.x, location.y - oldLocation.y)
            selectionView!.frame = CGRect(origin: oldLocation, size: thisSize!)
        }
        else if (location.x - oldLocation.x) > 0 && (location.y - oldLocation.y) < 0
        {
            thisSize = CGSizeMake(location.x - oldLocation.x, oldLocation.y - location.y)
            let origin = CGPointMake(oldLocation.x, location.y)
            selectionView!.frame = CGRect(origin: origin, size: thisSize!)
        }
        
        
        for sView in stickieStack.items
        {
            if selectionView!.frame.intersects(sView.frame) == true
            {
                sView.layer.borderColor = STICKIE_BORDER_COLOR_SELECTED.CGColor
            }
        }
        
        
        
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //print("touchesEnded")
     

    }

}

