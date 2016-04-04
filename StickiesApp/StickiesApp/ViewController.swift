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

}

