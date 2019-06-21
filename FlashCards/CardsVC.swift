//
//  CardsVC.swift
//  FlashCards
//
//  Created by Christopher Walter on 6/18/19.
//  Copyright © 2019 AssistStat. All rights reserved.
//

import UIKit

class CardsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cardsTableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var deck: Deck?
    var cards: [Card] = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCards()
        
        cardsTableView.tableFooterView = UIView() // this will remove the extra empty cells at bottom of tableview
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let theDeck = deck
        {
            self.title = theDeck.name
        }
        cardsTableView.reloadData()
        deleteButton.isHidden = true
        deleteButton.layer.cornerRadius = 10.0
    }
    
    // MARK: Saving, Loading, Removing, Updating, CoreData Stuff
    func loadCards()
    {
        if let theDeck = deck
        {
            cards = Array(theDeck.cards ?? []) as! [Card]
            cardsTableView.reloadData()
        }
        // ToDo Load Cards From CoreData... They are currently passed in from deckVC along with the Deck.
        
    }
    
    func saveNewCard(s1:String, s2:String)
    {

        let newCard = Card(s1: s1, s2: s2)
        cards.append(newCard) // update the cards
        
        deck?.cards = NSSet(array: cards) // update the decks cards
        
        self.cardsTableView.reloadData()
        
        // ToDo Save Card to Core Data
    }
    
    func deleteDeck()
    {
        // ToDo  delete entire Deck from Core Data including cards
    }
    
    func deleteCardAt(index: Int)
    {
        // ToDo delete card from Core Data
        if let theDeck = deck
        {
            cards.remove(at: index)
            theDeck.cards = NSSet(array: cards) // update the decks cards
        }
    }
    
    func updateCard(card: Card, s1:String, s2:String, correct: Int, incorrect: Int)
    {
        card.side1 = s1
        card.side2 = s2
        card.correctCount = correct
        card.incorrectCount = incorrect
        // ToDo update card in CoreData
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: getAlertTitle(), message: "Enter Card Details", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {textfield in
            textfield.placeholder = "Side 1"
            textfield.adjustsFontSizeToFitWidth = true
            textfield.autocapitalizationType = .sentences
        })
        alert.addTextField(configurationHandler: {textfield in
            textfield.placeholder = "Side 2"
            textfield.adjustsFontSizeToFitWidth = true
            textfield.autocapitalizationType = .sentences
        })
        let addAction = UIAlertAction(title: "Add Card", style: .default, handler: {action in
            let side1 = alert.textFields?[0].text ?? "Error"
            let side2 = alert.textFields?[1].text ?? "Error2"
            
            self.saveNewCard(s1: side1, s2: side2)
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func getAlertTitle() -> String
    {
        if let theDeck = deck
        {
            return "Add a Card to \(theDeck.name ?? "Error")"
        }
        else
        {
            return "Add a Card"
        }
    }
    

    @IBAction func editButtonTapped(_ sender: UIBarButtonItem)
    {
        cardsTableView.isEditing = !cardsTableView.isEditing
        if cardsTableView.isEditing
        {
            deleteButton.isHidden = false
        }
        else
        {
            deleteButton.isHidden = true
        }
    }
    
    @IBAction func deleteDeckAndCardsTapped(_ sender: UIButton) {
        // ToDo Delete entire Deck from CoreData
        // delete Deck and pop view controller
        deleteDeck()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CardTableViewCell
    
        let theCard = cards[indexPath.row]
        
        cell.card = theCard // propties and labels will be set in CardTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            deleteCardAt(index: indexPath.row) // helper method to delete card

            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let theCard = cards[indexPath.row]
        
        // create an alert where we can edit the values
        let alert = UIAlertController(title: getAlertTitle(), message: "Edit Card Details", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {textfield in
            textfield.placeholder = "Side 1"
            textfield.adjustsFontSizeToFitWidth = true
            textfield.autocapitalizationType = .sentences
            textfield.text = theCard.side1
        })
        alert.addTextField(configurationHandler: {textfield in
            textfield.placeholder = "Side 2"
            textfield.adjustsFontSizeToFitWidth = true
            textfield.autocapitalizationType = .sentences
            textfield.text = theCard.side2
        })
        let addAction = UIAlertAction(title: "Save Edits", style: .default, handler: {action in
            let side1 = alert.textFields?[0].text ?? "Error"
            let side2 = alert.textFields?[1].text ?? "Error2"
            self.updateCard(card: theCard, s1: side1, s2: side2, correct: theCard.correctCount, incorrect: theCard.incorrectCount)
            
            self.cardsTableView.reloadData()
            
        })
        let resetStatsAction = UIAlertAction(title: "Reset Stats", style: .destructive, handler: {action in
            // get possibly new textfield values...
            let side1 = alert.textFields?[0].text ?? "Error"
            let side2 = alert.textFields?[1].text ?? "Error2"
            
            self.updateCard(card: theCard, s1: side1, s2: side2, correct: 0, incorrect: 0)
            self.cardsTableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(resetStatsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToGameSegue"
        {
            let destVC = segue.destination as! GameVC
            destVC.deck = deck
        }
    }
    

}
