//
//  Constants.swift
//  StickiesApp
//
//  Created by Ganesh on 06/04/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import Foundation
import UIKit

let STICKIE_WIDTH = 150
let STICKIE_HEIGHT = 120
let STICKIE_CORNER = 1
let STICKIE_BORDER_WIDTH = 3
let STICKIE_BORDER_COLOR = RGBCOLOR(0xe6a52d)
let STICKIE_BORDER_COLOR_SELECTED = RGBCOLOR(0x3ab24f)
let STICKIE_BORDER_COLOR_EDITING = RGBCOLOR(0x3a7790)
let STICKIE_BACKGROUND_COLOR = RGBCOLOR(0xe4be64)
let GENERAL_KEYBOARD_HEIGHT = 256.0



func RGBCOLOR(value: Int) -> UIColor
{
    return UIColor(red: ((CGFloat)((value & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((value & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(value & 0xFF))/255.0, alpha: 1.0)
}
