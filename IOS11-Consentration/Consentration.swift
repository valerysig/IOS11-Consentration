//
//  Consentration.swift
//  IOS11-Consentration
//
//  Created by Valery Sigal on 07/10/2018.
//  Copyright © 2018 Valery Sigal. All rights reserved.
//

import Foundation

class Consentration {
    //MARK: Members
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard : Int?
    var chosenCards = Set<Int>()
    var score = 0.0
    var flipCount = 0
    let startTime = Date().timeIntervalSince1970
    
    //MARK: Properties
    var timeSinceGameStart : Double {
        return Date().timeIntervalSince1970 - startTime
    }
    
    var cardMatchScore : Double {
        return 100 / timeSinceGameStart
    }
    
    //MARK: Constructors
    init(numberOfPairsOfCards : Int) {
        Card.identifierFactory = 0
        populateCards(numberOfPairsOfCards)
        shuffleCards()
    }
    
    //MARK: Methods
    func chooseCard(at index : Int) {
        if !cards[index].isMatched {
            flipCount += 1
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    score += cardMatchScore
                } else if (chosenCards.contains(index)) {
                    score -= 1
                }
                cards[index].isFaceUp = true
                chosenCards.insert(index)
                
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                chosenCards.insert(index)
                
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    //MARK: Private Methods
    func populateCards(_ numberOfPairsOfCards : Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
    }
    
    func shuffleCards() {
        var shuffledCards = [Card]()
        for _ in cards.indices {
            let randomIndex = cards.count.getRandomNumUpToIt()
            shuffledCards.append(cards.remove(at: randomIndex))
        }
        
        cards = shuffledCards
    }
}
