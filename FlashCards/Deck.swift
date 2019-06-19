//
//  Deck.swift
//  FlashCards
//
//  Created by Christopher Walter on 6/18/19.
//  Copyright © 2019 AssistStat. All rights reserved.
//

import Foundation

class Deck
{
    var name: String
    var cards: [Card]
    
    init()
    {
        name = "TestDeck"
        cards = [Card]()
    }
    init(n: String)
    {
        name = n
        cards = [Card]()
    }
    init(n: String, c: [Card])
    {
        name = n
        cards = c
    }
}
