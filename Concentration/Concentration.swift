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
    init(numberOfPairsOfCard: Int) {
        for _ in 1...numberOfPairsOfCard {
            // _ means no variable to be used
            let card = Card()
            cards += [card, card]
            // card is struct and structs are copied
            // each time we create new array of size 2
            // of card and appended to the array of cards

            // notice that coping the card makes 2 cards
            // have the same identifier number which results
            // in creating pairs of the same shape
            // to check it print(card.identifier)
        }
        cards.shuffle()
        // TODO: Shuffle the cards
    }

    func chooseCard (at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
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
    }
}
