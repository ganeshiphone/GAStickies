//
//  ViewController.swift
//  StickiesApp
//
//  Created by Ganesh on 05/04/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let pasteBoard:UIPasteboard = UIPasteboard.pasteboardWithUniqueName()
    var stickieStack = StickieStack()
    var selectionView : SelectionView?
    
    var copiedStickies: [StickieView]? = []
    
    @IBOutlet weak var copyButton: UIBarButtonItem!
    @IBOutlet weak var cutButton: UIBarButtonItem!
    @IBOutlet weak var pasteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.cutButton.enabled = false
        self.copyButton.enabled = false
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newButtonTapped(sender: UIBarButtonItem)
    {
        self.view.endEditing(true)
        addStickieView(StickieView())
    }
    
    
    @IBAction func copyButtonTapped(sender: UIBarButtonItem)
    {
        self.view.endEditing(true)
        selectionView?.removeFromSuperview()
        guard let stickies = stickieStack.copiedStickies() else { return }
        copiedStickies = stickies
        let copyData: NSData? = NSKeyedArchiver.archivedDataWithRootObject(copiedStickies!)
        if let data = copyData
        {
            pasteBoard.setData(data, forPasteboardType:"public.data")
        }
        
        var copiedImages: [UIImage]? = []
        for aView in copiedStickies!
        {
            let image = UIImage(view: aView)
            copiedImages?.append(image)
        }
        
        UIPasteboard.generalPasteboard().images = copiedImages
        
        
        
        
        self.pasteButton.enabled = copiedStickies?.count > 0
    }
    
    @IBAction func cutButtonTapped(sender: UIBarButtonItem)
    {
        self.view.endEditing(true)
        selectionView?.removeFromSuperview()
        guard let stickies = stickieStack.copiedStickies() else { return }
        copiedStickies = stickies
        
        self.pasteButton.enabled = copiedStickies?.count > 0
        
        for ctView in copiedStickies!
        {
            ctView.removeFromSuperview()
        }

        stickieStack.removeStickies(copiedStickies!)
        
        let copyData: NSData? = NSKeyedArchiver.archivedDataWithRootObject(copiedStickies!)
        if let data = copyData
        {
            pasteBoard.setData(data, forPasteboardType:"public.data")
        }
        
        
        var copiedImages: [UIImage]? = []
        for aView in copiedStickies!
        {
            let image = UIImage(view: aView)
            copiedImages?.append(image)
        }
        
        UIPasteboard.generalPasteboard().images = copiedImages
        
      
    }
    
    
    @IBAction func pasteButtonTapped(sender: UIBarButtonItem)
    {
        selectionView?.removeFromSuperview()
        self.view.endEditing(true)
        let copyData: NSData? = pasteBoard.dataForPasteboardType("public.data")
        if let data = copyData
        {
            guard let stickies = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [StickieView]? else {return}
            copiedStickies = stickies
            for cpView in copiedStickies!
            {
                cpView.isSelected = false
                addStickieView(cpView)
            }
            
        }
        
        self.cutButton.enabled = false
        self.copyButton.enabled = false
        
    }
    
    func addStickieView(stickie: StickieView)
    {
        self.view.addSubview(stickie)
        if let previousView = stickieStack.currentStickie()
        {
            stickie.center = CGPointMake(previousView.center.x+5.0, previousView.center.y+5.0)
        }
        else
        {
            stickie.center = self.view.center
        }
        stickieStack.push(stickie)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        selectionView?.removeFromSuperview()
        selectionView = SelectionView()
         self.view.addSubview(selectionView!)
        
        let touch = touches.first
        let location = touch!.locationInView(self.view)
        selectionView!.frame = CGRect(origin: location, size: selectionView!.frame.size)
        
        copiedStickies = []
        
        self.cutButton.enabled = false
        self.copyButton.enabled = false
        
        stickieStack.unSelectAllStickies()
        
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
      
        
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
                sView.isSelected = true
            }
            else
            {
                sView.isSelected = false
            }
        }
        
        
        
        
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.cutButton.enabled = stickieStack.copiedStickies()?.count > 0
        self.copyButton.enabled = self.cutButton.enabled

    }

}

