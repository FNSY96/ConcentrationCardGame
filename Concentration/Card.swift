//
//  Card.swift
//  Concentration
//
//  Created by Fady Nabil Samy on 15/2/19.
//  Copyright © 2019 Fady Nabil Samy. All rights reserved.
//

import Foundation

// struct has no inheritance

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var countFaceUp = 0

    static var identifierFactory = -1

    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
