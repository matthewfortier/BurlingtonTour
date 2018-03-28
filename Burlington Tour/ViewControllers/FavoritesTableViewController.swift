//
//  FavoritesViewController.swift
//  Burlington Tour
//
//  Created by Seielstad, Morgan on 3/24/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {
    
    var itemStore: ItemStore!
   
    

//  https://www.andrewcbancroft.com/2015/03/17/basics-of-pull-to-refresh-for-swift-developers/
    @IBAction func refresh(_ sender: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(FavoritesViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        navigationItem.leftBarButtonItem = editButtonItem
        let nib = UINib.init(nibName: "PlaceCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "PlaceCell")
        //tableView.rowHeight = CGFloat(100)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        //itemStore.loadFavorites()
   
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let c = self.itemStore.favoritesArray as NSArray
        return c.count
        
    }
    

    /*
     
     We need the following function to be able to segue to the proper view from the cell type.... this should be possible if we can check the id.  trickier if we have to mangle the cells.
     
     */
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // Update the model
        itemStore.moveFavorite(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let c = itemStore.favoritesArray[indexPath.row]
        switch c {
            case is Place:
                performSegue(withIdentifier: "favPlaceSegue", sender: indexPath.row)
            case is Tour:
                performSegue(withIdentifier: "favTourSegue", sender: indexPath.row)
            case is Note:
                performSegue(withIdentifier: "favNoteSegue", sender: indexPath.row)
            default:
                print("ohshit")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)    
        let fav = itemStore.favoritesArray[indexPath.row]
        
        switch fav {
        case is Tour:
            
            let c : Tour = fav as! Tour
            cell.textLabel?.text = c.title
            if c.type == "audio" {
                cell.imageView?.image = UIImage(named: "audio")
            } else {
                cell.imageView?.image = UIImage(named: "video")
            }
            
            tableView.rowHeight = CGFloat(50)
         
            return cell
            
        case is Place:
            let cellplace = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
            let c : Place = fav as! Place
            
            cellplace.CellLabel.text = c.title
            cellplace.CellImage.image = UIImage(named: c.image)
            
            tableView.rowHeight = CGFloat(100)
            
            return cellplace
       
        case is Note:
            let cellNote = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
            let note : Note = itemStore.favoritesArray[indexPath.row] as! Note
            
            cellNote.CellLabel.text = note.title
            cellNote.CellImage.image = note.image
            tableView.rowHeight = CGFloat(100)
            return cellNote
        default:
            print("broken, should not be here")
            
        }
        /*
         cell.textLabel?.text = .title
         if tour.type == "audio" {
         cell.imageView?.image = UIImage(named: "audio")
         } else {
         cell.imageView?.image = UIImage(named: "video")
         }
         */
     
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
                      
     
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                             handler: { (action) -> Void in
                                                // Remove the item from the store
                                                self.itemStore.removeFavorite(row: indexPath.row)
                                                
                                                // Also remove that row from the table view with an animation
                                                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favPlaceSegue" {
            if let pvc = segue.destination as? PlaceViewController, let selectedRow = tableView.indexPathForSelectedRow?.row {
                if let place : Place = itemStore.favoritesArray[selectedRow] as? Place{
                    print(place.title)
                    pvc.image = place.image
                    pvc.body = place.body
                    pvc.navTitle = place.title
                    pvc.lat = place.lat
                    pvc.lon = place.lon
                    pvc.fav = place.fav
                    print(place.body)
                }
            }
        }
        if segue.identifier == "favTourSegue" {
            if let tvc = segue.destination as? TourViewController, let selectedRow = tableView.indexPathForSelectedRow?.row {
                    if let tour : Tour = itemStore.favoritesArray[selectedRow] as? Tour{
                        print(tour.title)
                    tvc.tourTitle = tour.title
                    tvc.file = tour.file
                }
            }
        }
        if segue.identifier == "favNoteSegue" {
            if let nvc = segue.destination as? NoteViewController, let selectedRow = tableView.indexPathForSelectedRow?.row  {
                nvc.itemStore = itemStore
                nvc.note = itemStore.notes[selectedRow]
                nvc.row = selectedRow
            } else {
                let nvc = segue.destination as? NoteViewController
                nvc?.itemStore = itemStore
            }
        }
    }
}

