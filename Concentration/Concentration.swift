//
//  Concentration.swift
//  Concentration
//
//  Created by Fady Nabil Samy on 15/2/19.
//  Copyright © 2019 Fady Nabil Samy. All rights reserved.
//

import Foundation

class Concentration {
    var cards = Array<Card>()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipped = Dictionary<Int, Int>()
    var score = 0
    var flipCount = 0

    init(numberOfPairsOfCard: Int) {
        Card.identifierFactory = -1
        self.score = 0
        self.flipCount = 0
        for identifier in 0..<numberOfPairsOfCard {
            let card = Card()
            cards += [card, card]
            flipped[identifier] = 0
            // card is struct and structs are copied
            // each time we create new array of size 2
            // of card and appended to the array of cards

            // notice that coping the card makes 2 cards
            // have the same identifier number which results
            // in creating pairs of the same shape
            // to check it print(card.identifier)
        }
        cards.shuffle()
    }

    func chooseCard (at index: Int) -> Bool {
        var isMatched = false
        if !cards[index].isMatched {
            incrementFlips(at: index)
            checkPreviouslySeen(at: index);
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    self.score += 2
                    isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        return isMatched
    }

    func checkPreviouslySeen(at index: Int) {
        if !cards[index].isMatched {
            cards[index].countFaceUp += 1
            if cards[index].countFaceUp > 3 {
                self.score -= 1
            }
        }
    }

    func incrementFlips(at index: Int) {
        flipCount = (!cards[index].isFaceUp) ? flipCount + 1 : flipCount
    }
}
