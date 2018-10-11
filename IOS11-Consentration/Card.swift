//
//  Card.swift
//  IOS11-Consentration
//
//  Created by Valery Sigal on 07/10/2018.
//  Copyright © 2018 Valery Sigal. All rights reserved.
//

import Foundation

struct Card : Hashable {
    
    //MARK: Static Members
    private static var identifierFactory = 0
    
    //MARK: Members
    var isFaceUp = false
    var isMatched = false
    private var identifier : Int
    
    //MARK: Properties
    var hashValue : Int {
        return identifier
    }
    
    //MARK: Constructors
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    //MARK: Static Methods
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    static func ==(lhs : Card, rhs : Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}
