//
//  Extensions.swift
//  IOS11-Consentration
//
//  Created by Valery Sigal on 08/10/2018.
//  Copyright © 2018 Valery Sigal. All rights reserved.
//

import Foundation

extension Int {
    var arc4random : Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

extension Collection {
    var oneAndOnly : Element? {
        return count == 1 ? first : nil
    }
}
