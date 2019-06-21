//
//  CardTableViewCell.swift
//  FlashCards
//
//  Created by Christopher Walter on 6/18/19.
//  Copyright © 2019 AssistStat. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var card : Card? {
        didSet {
            if let theCard = card
            {
                label1.text = theCard.side1
                label2.text = theCard.side2

                detailLabel.text = "\(theCard.correctCount)/\(theCard.correctCount + theCard.incorrectCount)"
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 3.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
