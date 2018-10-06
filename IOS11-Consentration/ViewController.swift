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
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    var emojiChoices : Array<String> = ["🎃", "👻", "🎃", "👻"]
    
    //MARK: Methods
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    //MARK: Private meghods
    func flipCard(withEmoji emoji : String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}

