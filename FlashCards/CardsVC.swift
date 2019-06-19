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
    
    var deck: Deck?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadCards()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let theDeck = deck
        {
            self.title = theDeck.name
        }
        cardsTableView.reloadData()
        
    }
    
    
    func loadCards()
    {
//        if let theDeck = deck
//        {
//
//            cardsTableView.reloadData()
//        }
        
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
            let newCard = Card(s1: side1, s2: side2)
            self.deck?.cards.append(newCard) // update the deck's cards
            self.cardsTableView.reloadData()
            
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
            return "Add a Card to \(theDeck.name)"
        }
        else
        {
            return "Add a Card"
        }
    }
    
    @IBAction func playTapped(_ sender: UIBarButtonItem)
    {
        
    }
    
    // MARK: TableView properties
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let theDeck = deck
        {
            return theDeck.cards.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CardTableViewCell
        
        if let theDeck = deck
        {
            let theCard = theDeck.cards[indexPath.row]
            
            cell.card = theCard // propties and labels will be set in CardTableViewCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let theDeck = deck
        {
            let theCard = theDeck.cards[indexPath.row]
            
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
            let addAction = UIAlertAction(title: "Edit Card", style: .default, handler: {action in
                let side1 = alert.textFields?[0].text ?? "Error"
                let side2 = alert.textFields?[1].text ?? "Error2"
                theCard.side1 = side1
                theCard.side2 = side2
                
                self.cardsTableView.reloadData()
                
            })
            let resetStatsAction = UIAlertAction(title: "Reset Stats", style: .destructive, handler: {action in
                // get possibly new textfield values...
                let side1 = alert.textFields?[0].text ?? "Error"
                let side2 = alert.textFields?[1].text ?? "Error2"
                theCard.side1 = side1
                theCard.side2 = side2
                
                theCard.correctCount = 0
                theCard.incorrectCount = 0
                
                self.cardsTableView.reloadData()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(addAction)
            alert.addAction(resetStatsAction)
            alert.addAction(cancelAction)
            

            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToGameSegue"
        {
            let destVC = segue.destination as! GameVC
            destVC.deck = deck
        }
    }
    

}
