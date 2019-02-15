//
//  Theme.swift
//  Concentration
//
//  Created by Fady Nabil Samy on 15/2/19.
//  Copyright © 2019 Fady Nabil Samy. All rights reserved.
//

import Foundation

class Theme {

    var themes = Dictionary<Int, Array<String>>()
    lazy var numberOfThemes = themes.count

    init() {
        self.setThemes()
    }
    private func setThemes() {
        themes[0] = ["😀", "😃", "😄", "😁", "😆", "😍", "😎", "😜", "😱", "😝"]
        themes[1] = ["🍏", "🍎", "🍓", "🌮", "🥑", "🍣", "🥪", "🍉", "🍇", "🥥"]
        themes[2] = ["⚽️", "🏀", "🏈", "🎱", "🎾", "🏓", "🏐", "🥅", "🥌", "🛷"]
        themes[3] = ["🌅", "💒", "🏨", "🗿", "🚦", "🚝", "🚨", "🚎", "🚐", "🚗"]
        themes[4] = ["❤️", "✝️", "🆘", "♏️", "⚛️", "🔱", "✳️", "🌀", "🎦", "🌐"]
        themes[5] = ["🇧🇷", "🇦🇷", "🇨🇦", "🇪🇬", "🇩🇪", "🇬🇪", "🇯🇵", "🇹🇫", "🇱🇧", "🇳🇬"]
    }

    func getTheme() -> Array<String> {
        let randomNumber = Int(arc4random_uniform(UInt32(self.numberOfThemes)))
        return self.themes[randomNumber]!
    }
}
