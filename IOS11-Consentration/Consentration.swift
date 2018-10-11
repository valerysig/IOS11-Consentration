//
//  Consentration.swift
//  IOS11-Consentration
//
//  Created by Valery Sigal on 07/10/2018.
//  Copyright © 2018 Valery Sigal. All rights reserved.
//

import Foundation

struct Consentration {
    //MARK: Members
    private(set) var cards = [Card]()
    private var chosenCards = Set<Int>()
    var score = 0.0
    private(set) var flipCount = 0
    private let startTime = Date().timeIntervalSince1970
    
    //MARK: Properties
    private var indexOfOneAndOnlyFaceUpCard : Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var timeSinceGameStart : Double {
        return Date().timeIntervalSince1970 - startTime
    }
    
    var cardMatchScore : Double {
        return 100 / timeSinceGameStart
    }
    
    //MARK: Constructors
    init(numberOfPairsOfCards : Int) {
        assert(numberOfPairsOfCards > 0, "Consentration.init(\(numberOfPairsOfCards)): you must have at least 1 pairs of cards")
        
        populateCards(numberOfPairsOfCards)
        shuffleCards()
    }
    
    //MARK: Methods
    mutating func chooseCard(at index : Int) {
        assert(cards.indices.contains(index), "Consentration.chooseCard(at: \(index)): chosen index no in the cards")
        
        if !cards[index].isMatched {
            flipCount += 1
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    score += cardMatchScore
                } else if (chosenCards.contains(index)) {
                    score -= 1
                }
                cards[index].isFaceUp = true
                chosenCards.insert(index)
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
                chosenCards.insert(index)
            }
        }
    }
    
    //MARK: Private Methods
    private mutating func populateCards(_ numberOfPairsOfCards : Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
    }
    
    private mutating func shuffleCards() {
        var shuffledCards = [Card]()
        for _ in cards.indices {
            let randomIndex = cards.count.arc4random
            shuffledCards.append(cards.remove(at: randomIndex))
        }
        
        cards = shuffledCards
    }
}
