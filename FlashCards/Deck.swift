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
    var name: String?
    var cards: NSSet?
//    var cards: [Card]
    
    init()
    {
        name = "TestDeck"
        cards = NSSet(array: [Card]())
    }
    init(n: String)
    {
        name = n
        cards = NSSet(array: [Card]())
    }
    init(n: String, c: [Card])
    {
        name = n
        cards = NSSet(array: c)
    }
    
    func getStatString() -> String
    {
        var correctCount = 0
        var incorrectCount = 0
        for card in Array(cards ?? [])
        {
            let theCard = card as! Card
            correctCount += theCard.correctCount
            incorrectCount += theCard.incorrectCount
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
        for card in Array(cards ?? [])
        {
            let theCard = card as! Card
            correctCount += theCard.correctCount
            incorrectCount += theCard.incorrectCount
        }
        return "\(correctCount)/\(correctCount + incorrectCount)"
    }
}
