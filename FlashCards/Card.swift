//
//  Card.swift
//  FlashCards
//
//  Created by Christopher Walter on 6/18/19.
//  Copyright © 2019 AssistStat. All rights reserved.
//

import Foundation

class Card
{
    var side1: String
    var side2: String
    var correctCount: Int
    var incorrectCount: Int
    
    init()
    {
        side1 = "test"
        side2 = "test2"
        correctCount = 0
        incorrectCount = 0
    }
    
    init(s1: String, s2: String)
    {
        side1 = s1
        side2 = s2
        correctCount = 0
        incorrectCount = 0
    }
    
    
    func getStatString() -> String
    {
        var result = "\(correctCount)/\(correctCount + incorrectCount)"
        if (correctCount + incorrectCount) > 0
        {
            let average = Double(correctCount) / Double(correctCount + incorrectCount)
            let averageString = String(format: "%.2f", average)
            result += " = \(averageString)"
        }
        return result
    }
    
    func getBasicStatString() -> String
    {
        return "\(correctCount)/\(correctCount + incorrectCount)"
    }
    
    
}
