//
//  StickieStack.swift
//  StickiesApp
//
//  Created by Ganesh on 4/7/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import Foundation
import UIKit

struct StickieStack
{
    var items:[StickieView] = []
    mutating func push(item: StickieView)
    {
        items.insert(item, atIndex: 0)
    }
    mutating func pop()
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
    func copiedStickies() -> [StickieView]?
    {
        var bunchOFStickies: [StickieView]? = []
        for cpView in self.items
        {
            if cpView.isSelected == true
            {
                bunchOFStickies?.append(cpView)
            }
        }
        return bunchOFStickies
    }
    
    mutating func removeStickies(stickies: [StickieView])
    {
        items = Array(Set(items).subtract(stickies))
    }
    
    func unSelectAllStickies()
    {
        for sView in items
        {
            sView.isSelected = false
        }
    }
}