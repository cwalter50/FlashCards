//
//  DecksVC.swift
//  FlashCards
//
//  Created by Christopher Walter on 6/18/19.
//  Copyright © 2019 AssistStat. All rights reserved.
//

import UIKit

class DecksVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var deckCollectionView: UICollectionView!
    
    var decks: [Deck] = [Deck]()
    
    var selectedDeck: Deck?
    
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
        cell.backgroundColor = UIColor.white
        cell.titleLabel.textColor = UIColor.darkGray
        cell.layer.cornerRadius = 10.0
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 3.0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDeck = decks[indexPath.row]
        print("didSelectItem called")
        performSegue(withIdentifier: "ToCardSegue", sender: self)
        
    }
    
    // MARK: layout for collectionview cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 3 - 15.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCardSegue"
        {
            print("prepare for segue called")
            let destVC = segue.destination as! CardsVC

            destVC.deck = selectedDeck
        }
    }
    
    

}
