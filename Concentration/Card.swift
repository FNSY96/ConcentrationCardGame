//
//  Card.swift
//  Concentration
//
//  Created by Fady Nabil Samy on 15/2/19.
//  Copyright © 2019 Fady Nabil Samy. All rights reserved.
//

import Foundation

// struct has no inheritance

// Implements hashable protocol/interface
// to be used as a key in dictionary
// as dictionaries don't allow keys that
// don't implement Hashable

struct Card: Hashable {

    var hashValue: Int {
        return self.identifier
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    var countFaceUp = 0

    static var identifierFactory = -1

    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
