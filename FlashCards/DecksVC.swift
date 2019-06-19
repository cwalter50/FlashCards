//
//  DecksVC.swift
//  FlashCards
//
//  Created by Christopher Walter on 6/18/19.
//  Copyright © 2019 AssistStat. All rights reserved.
//

import UIKit

class DecksVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var deckCollectionView: UICollectionView!
    
    var decks: [Deck] = [Deck]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

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
            let newDeck = Deck(n: name)
            self.decks.append(newDeck)
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
        cell.backgroundColor = UIColor.darkGray
        cell.titleLabel.textColor = UIColor.white
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCardSegue"
        {
            
        }
    }
    
    

}
