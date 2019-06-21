//
//  DecksVC.swift
//  FlashCards
//
//  Created by Christopher Walter on 6/18/19.
//  Copyright © 2019 AssistStat. All rights reserved.
//

import UIKit
import CoreData

class DecksVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var deckCollectionView: UICollectionView!
    
    var decks: [Deck] = [Deck]()
    
    var selectedDeck: Deck?
    
    // This gives us a reference to the AppDelegate and the Persistent Container for CoreData
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        createSampleDecks()
        self.title = "Flash Cards"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadDecks()
    }
    
    func loadDecks()
    {
        // ToDo load decks from CoreData
        
        // create fetch Request
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Deck")

        // load the decks
        do {
            decks = try managedContext.fetch(fetchRequest) as! [Deck]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func saveDeck(n: String)
    {
//        let newDeck = Deck(n: n)
//        self.decks.append(newDeck)
        // ToDo save deck to CoreData
        
        // Create Instance of the entity for Deck
        let entity =
            NSEntityDescription.entity(forEntityName: "Deck",
                                       in: managedContext)!
        // Create the new Deck
        let newDeck = Deck(entity: entity, insertInto: managedContext)
        
        // Set the new Deck's Properties
        newDeck.name = n
        
        // Actually Save the Deck
        do {
            try managedContext.save()
            decks.append(newDeck)
            deckCollectionView.reloadData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Add a Deck", message: "Enter Deck Name", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {textfield in
            textfield.placeholder = "DECK NAME"
            textfield.adjustsFontSizeToFitWidth = true
            textfield.autocapitalizationType = .words
        })
        let addAction = UIAlertAction(title: "Add Deck", style: .default, handler: {action in
            let name = alert.textFields?[0].text ?? "Error"
            self.saveDeck(n: name) // helper function to save to CareData
            
            self.deckCollectionView.reloadData()
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return decks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! DeckCollectionViewCell
        
        let theDeck = decks[indexPath.row]
        cell.deck = theDeck // titleLabel gets set in DeckCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.titleLabel.textColor = UIColor.darkGray
        cell.layer.cornerRadius = 10.0
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 3.0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDeck = decks[indexPath.row] 
        performSegue(withIdentifier: "ToCardSegue", sender: self)
        
    }
    
    // MARK: layout for collectionview cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        var cellWidth: CGFloat = 0.0
        if width > 500 // ipad screen, 3 cells per row
        {
            cellWidth = width / 3 - 15.0
            
        }
        else
        {// iphone screen 2 cells per row
            cellWidth = width / 2 - 15.0
        }
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    // these are sample Decks, so That I can interact with the program while in development.
    func createSampleDecks()
    {
//        let cardsA = [Card(s1: "Hulk", s2: "Bruce Banner"),Card(s1: "Iron Man", s2: "Tony Stark"), Card(s1: "Captain America", s2: "Steve Rogers"), Card(s1: "Spiderman", s2: "Peter Parker"), Card(s1: "Black Widow", s2: "Natasha Romamova"), Card(s1: "Hawkeye", s2: "Clint Barton"), Card(s1: "Thor", s2: "Thor Odinson"), Card(s1: "Black Panther", s2: "King T'Challa")]
//        let deckA = Deck(n: "Superheros", c: cardsA)
//        
//        let cardsB = [Card(s1: "QuarterBack", s2: "Carson Wentz"), Card(s1: "Wide Reciever", s2: "Dasean Jackson"), Card(s1: "TightEnd", s2: "Zach Ertz"), Card(s1: "Defensive Tackle", s2: "Fletcher Cox")]
//        let deckB = Deck(n: "Eagles", c: cardsB)
//
//        let cardsC = [Card(s1: "Bob Brown", s2: "Illinois"), Card(s1: "Stacy Sniegowski", s2: "Illinois"), Card(s1: "Steve Peterson", s2: "PA")]
//        let deckC = Deck(n: "Teacher's State or Location", c: cardsC)
//        
//        decks.append(deckA)
//        decks.append(deckB)
//        decks.append(deckC)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCardSegue"
        {
            let destVC = segue.destination as! CardsVC

            destVC.deck = selectedDeck
        }
    }
    
    

}
