//
//  GameVC.swift
//  FlashCards
//
//  Created by Christopher Walter on 6/19/19.
//  Copyright © 2019 AssistStat. All rights reserved.
//

import UIKit

class GameVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var wrongButton: UIButton!
    
    // MARK: Properties
    var deck : Deck?
    var count = 0 // this will be used to keep track of placement in the cards...
    {
        didSet
        {
            if count >= deck?.cards.count ?? 0 // reset count to zero when we get through all the cards
            {
                count = 0
            }
        }
    }
    var currentCard: Card? {
        // every time currentCard gets set, update the mainLabel and statLabel
        didSet
        {
            if let theCard = currentCard, let theDeck = deck
            {
                // update statLabel
                statLabel.text = theDeck.getBasicStatString()
                
                // get a random number from 1 - 2 to decide if we display side1 or side2. The text will be set in the animation
                let random = Int.random(in: 1...2)
                var displayString = ""
                if random == 1
                {
                    displayString = theCard.side1
                }
                else
                {
                    displayString = theCard.side2
                }
                
                // animate the newCard coming in
                let transitionOptions: UIView.AnimationOptions = [.transitionCurlUp, .showHideTransitionViews]
                UIView.transition(with: mainLabel, duration: 1.0, options: transitionOptions, animations: {
                    self.mainLabel.text = ""
                }, completion: { (action) in
                    self.mainLabel.text = displayString
                    })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        newGame()
    }
    
    func setUpViews()
    {
        // set the title
        if let theDeck = deck
        {
            self.title = theDeck.name
        }
        // make the label look like a card...
        mainLabel.layer.cornerRadius = 15
        mainLabel.layer.borderWidth = 5.0
        mainLabel.layer.borderColor = UIColor.darkGray.cgColor
        
    }
    func newGame()
    {
        if let theDeck = deck
        {
            // shuffle cards
            theDeck.cards.shuffle()
            nextCard()
        }
        
        
    }
    
    
    // MARK: Actions
    @IBAction func mainLabelTapped(_ sender: UITapGestureRecognizer)
    {
        // alternate between side1 and side2 of card when the label is tapped
        if let theCard = currentCard // safety first.. don't want to crash app on optional...
        {
            if mainLabel.text == theCard.side1
            {
                mainLabel.text = theCard.side2
            }
            else
            {
                mainLabel.text = theCard.side1
            }
            
            // flip animation
            let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
            UIView.transition(with: mainLabel, duration: 1.0, options: transitionOptions, animations: {
                // found this snippet online.  Could do a lot more with the transition in this code block.
            })
        }
        
    }
    
    @IBAction func wrongButtonTapped(_ sender: UIButton)
    {
        if let theCard = currentCard
        {
            theCard.incorrectCount += 1
            count += 1 // don't worry about going out of bounds, that is handled with a didSet
            nextCard()
        }
    }
    @IBAction func correctButtonTapped(_ sender: UIButton)
    {
        if let theCard = currentCard
        {
            theCard.correctCount += 1
            count += 1 // don't worry about going out of bounds, that is handled with a didSet
            nextCard()
        }
    }
    
    func nextCard()
    {
        if let theDeck = deck
        {
            // display side1 of the first card
            if count < theDeck.cards.count // make sure we don't go out of bounds for array
            {
                currentCard = theDeck.cards[count] // labels will be updated with a didSet in currentCard
            }
            else {
                mainLabel.text = "No Cards in Deck..."
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
