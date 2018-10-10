//
//  ViewController.swift
//  IOS11-Consentration
//
//  Created by Valery Sigal on 06/10/2018.
//  Copyright © 2018 Valery Sigal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Members
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var game : Consentration!
    private var emojiChoices : [String]!
    private var emoji : [Int : String]!
    
    var cardBackColor : UIColor!
    var cardFrontColor : UIColor!
    
    //MARK: Properties
    var numberOfPairsOfCards : Int {
        return (cardButtons.count + 1) / 2
    }
    
    //MARK: Constructors
    override func viewDidLoad() {
        super.viewDidLoad()
        clear()
    }
    
    //MARK: Methods
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    @IBAction private func touchNewGame() {
        clear()
    }
    
    //MARK: Private meghods
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = self.cardFrontColor
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : self.cardBackColor
            }
        }
        
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    private func emoji(for card : Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.count.arc4random
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private func clear() {
        let chosenTheme = ViewController.THEMES[ViewController.THEMES.count.arc4random]
        
        self.game = Consentration(numberOfPairsOfCards: numberOfPairsOfCards)
        self.emojiChoices = chosenTheme.emojis
        self.emoji = [Int : String]()
        
        self.view.backgroundColor = chosenTheme.background
        self.cardBackColor = chosenTheme.cardBack
        self.cardFrontColor = chosenTheme.cardFront
        
        flipCountLabel.textColor = cardBackColor
        scoreLabel.textColor = cardBackColor
        newGameButton.backgroundColor = cardBackColor
        newGameButton.setTitleColor(cardFrontColor, for: UIControlState.normal)
        
        updateViewFromModel()
    }
    
    //MARK: Constants
    private static let THEMES = [
        (emojis : ["😃", "😁", "😅", "😂", "☺️", "😇", "😍", "😎", "🤨"], background : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBack : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), cardFront : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), //Faces
        (emojis : ["🐶", "🐱", "🐹", "🐨", "🐸", "🐔", "🦄", "🐳", "🦍"], background : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBack : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), cardFront : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), //Animals
        (emojis : ["🍏", "🍎", "🍊", "🍋", "🍉", "🍇", "🍒", "🍑", "🥥"], background : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBack : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), cardFront : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), //Fruits
        (emojis : ["🥞", "🥩", "🍗", "🍖", "🌭", "🍔", "🍟", "🍕", "🥪"], background : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBack : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), cardFront : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), //Food
        (emojis : ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🎱", "🏓", "🏸", "🥅"], background : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBack : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), cardFront : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), //Sports
        (emojis : ["🚗", "🚕", "🚙", "🏎", "🚑", "🚒", "🚐", "🚃", "🚝"], background : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBack : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), cardFront : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))  //Transport
    ]
}

