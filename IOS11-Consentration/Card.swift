//
//  Card.swift
//  IOS11-Consentration
//
//  Created by Valery Sigal on 07/10/2018.
//  Copyright © 2018 Valery Sigal. All rights reserved.
//

import Foundation

struct Card {
    
    //MARK: Static Members
    static var identifierFactory = 0
    
    //MARK: Members
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    
    //MARK: Constructors
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    //MARK: Static Methods
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
}
