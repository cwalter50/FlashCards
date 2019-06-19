//
//  DeckCollectionViewCell.swift
//  FlashCards
//
//  Created by Christopher Walter on 6/18/19.
//  Copyright © 2019 AssistStat. All rights reserved.
//

import UIKit

class DeckCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var deck : Deck? {
        didSet {
            if let theDeck = deck
            {
                titleLabel.text = theDeck.name
            }
        }
    }
    
    
}
