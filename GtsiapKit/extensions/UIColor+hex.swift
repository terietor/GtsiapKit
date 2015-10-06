//
//  UIColor+hex.swift
//  GtsiapKit
//
//  Created by Giorgos Tsiapaliokas on 06/10/15.
//  Copyright © 2015 Giorgos Tsiapaliokas. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(hex: String, alpha: CGFloat = 1) {
        assert(hex[hex.startIndex] == "#", "Expected hex string of format #RRGGBB")

        let scanner = NSScanner(string: hex)
        scanner.scanLocation = 1  // skip #

        var rgb: UInt32 = 0
        scanner.scanHexInt(&rgb)

        self.init(
            red:   CGFloat((rgb & 0xFF0000) >> 16)/255.0,
            green: CGFloat((rgb &   0xFF00) >>  8)/255.0,
            blue:  CGFloat((rgb &     0xFF)      )/255.0,
            alpha: alpha)
    }
}