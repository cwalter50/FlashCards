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
    
    init()
    {
        side1 = "test"
        side2 = "test2"
    }
    
    init(s1: String, s2: String)
    {
        side1 = s1
        side2 = s2
    }
    
    
}
