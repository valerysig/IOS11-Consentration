//
//  Extensions.swift
//  IOS11-Consentration
//
//  Created by Valery Sigal on 08/10/2018.
//  Copyright © 2018 Valery Sigal. All rights reserved.
//

import Foundation

extension Int {
    func getRandomNumUpToIt() -> Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}
