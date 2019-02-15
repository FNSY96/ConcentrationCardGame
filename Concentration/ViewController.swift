//
//  ViewController.swift
//  Concentration
//
//  Created by Fady Nabil Samy on 14/2/19.
//  Copyright © 2019 Fady Nabil Samy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game  = Concentration(numberOfPairsOfCard: (cardButtons.count + 1) / 2)
    // since swift you have to completely intialize
    // the object before using any of its vars
    // cardButtons cannot be used before all variables
    // are initialized and game needs cardButtons to be initalized
    // which creates a deadlock, to avoid it we add lazy keyword
    // in which means gam e does not get initalized before it is used

    var emoji = Dictionary<Int, String>()
    var flipCount = 0 {
        didSet {
            // didSet is a property observer
            flipCountLabel.text = "Flips : \(flipCount)"
        }
    }

    @IBOutlet weak var flipCountLabel: UILabel!

    @IBOutlet var cardButtons: [UIButton]!

    var emojiChoices = ["😃", "😄", "😇", "😍", "😉", "😎", "🙀", "🎃", "👺", "🔥", "🤣", "🐠"]

    @IBAction func startNewGame(_ sender: UIButton) {

    }
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }

    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, self.emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = self.emojiChoices.remove(at: randomIndex)
        }

//       return self.emoji[card.identifier] == nil ? "?" : self.emoji[card.identifier]!
        return self.emoji[card.identifier] ?? "?"
        // both are equivalent to each other
        // we add the ! mark because emoji returns an "optional"
        // an optional means if it is there I will return it
        // but if not I will return "nil"
        // so ! is added as an optimistic case that all the return
        // is there and no "nil" will be returned
    }
}

