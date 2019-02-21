//
//  Concentration.swift
//  Concentration
//
//  Created by Fady Nabil Samy on 15/2/19.
//  Copyright © 2019 Fady Nabil Samy. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = Array<Card>()

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    foundIndex = (foundIndex == nil) ? index : nil
                }
            }
            return foundIndex
        }

        set/*(newValue)*/ {
            // need not to define the newValue as it is implicitly there
            for index in cards.indices {
                // set by true if the current index of the card
                // is the same index set
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    var flipped = Dictionary<Int, Int>()
    var score = 0
    var flipCount = 0

    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Enter a number > 0 as number of pairs")
        Card.identifierFactory = -1
        // TODO: Card.identifierFactory should be private in Card
        self.score = 0
        self.flipCount = 0
        for identifier in 0..<numberOfPairsOfCards {
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

    /* From swift documentation
     Structures and enumerations are value types. By default, the properties of a value type cannot be modified from within its instance methods.
     However, if you need to modify the properties of your structure or enumeration within a particular method, you can opt in to mutating behavior for that method. The method can then mutate (that is, change) its properties from within the method, and any changes that it makes are written back to the original structure when the method ends. The method can also assign a completely new instance to its implicit self property, and this new instance will replace the existing one when the method ends.
     */

    mutating func chooseCard (at index: Int) -> Bool {
        assert(cards.indices.contains(index), "Index out of range")
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
            } else {
                // either no cards or 2 cards are face up
                // all the code is moved to set of
                // indexOfOneAndOnlyFaceUpCard computed
                // property
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        return isMatched
    }

    mutating func checkPreviouslySeen(at index: Int) {
        if !cards[index].isMatched {
            cards[index].countFaceUp += 1
            if cards[index].countFaceUp > 3 {
                self.score -= 1
            }
        }
    }

    mutating func incrementFlips(at index: Int) {
        flipCount = (!cards[index].isFaceUp) ? flipCount + 1 : flipCount
    }
}
