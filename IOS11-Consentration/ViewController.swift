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
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var game : Consentration!
    var flipCount : Int! { didSet { flipCountLabel.text = "Flips: \(flipCount!)" } }
    var emojiChoices : [String]!
    var emoji : [Int : String]!
    
    //MARK: Constructors
    override func viewDidLoad() {
        super.viewDidLoad()
        clear()
    }
    
    //MARK: Methods
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount = flipCount + 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    @IBAction func touchNewGame() {
        clear()
    }
    
    //MARK: Private meghods
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    func emoji(for card : Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.count.getRandomNumUpToIt()
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func clear() {
        self.game = Consentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        self.flipCount = 0
        self.emojiChoices = StaticValues.THEMES[StaticValues.THEMES.count.getRandomNumUpToIt()]
        self.emoji = [Int : String]()
        updateViewFromModel()
    }
}

