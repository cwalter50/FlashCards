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
    
    func getStatString() -> String
    {
        var correctCount = 0
        var incorrectCount = 0
        for card in cards
        {
            correctCount += card.correctCount
            incorrectCount += card.incorrectCount
        }
        var result = "\(correctCount)/\(correctCount + incorrectCount)"
        if (correctCount + incorrectCount) > 0
        {
            let average = Double(correctCount) / Double(correctCount + incorrectCount) * 100
            let averageString = String(format: "%.1f", average)
            result += " = \(averageString)"
        }
        return result
    }
    
    func getBasicStatString() -> String
    {
        var correctCount = 0
        var incorrectCount = 0
        for card in cards
        {
            correctCount += card.correctCount
            incorrectCount += card.incorrectCount
        }
        return "\(correctCount)/\(correctCount + incorrectCount)"
    }
}
