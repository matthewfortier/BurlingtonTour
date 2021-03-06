//
//  FavoritesViewController.swift
//  Burlington Tour
//
//  Created by Seielstad, Morgan on 3/24/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit
import SafariServices
class FavoritesViewController: UITableViewController {
    
    var itemStore: ItemStore!
   
    //  https://www.andrewcbancroft.com/2015/03/17/basics-of-pull-to-refresh-for-swift-developers/
    //  Used for pull to refresh in favorites tableviewcontroller
    @IBAction func refresh(_ sender: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the BarButtonItems and register the tableviewcells
        self.refreshControl?.addTarget(self, action: #selector(FavoritesViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        navigationItem.leftBarButtonItem = editButtonItem
        let nib = UINib.init(nibName: "PlaceCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "PlaceCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Reload data on willappear and showing the edit button if there are any favorites
        tableView.reloadData()
        if itemStore.favorites.count > 0 {
            navigationItem.leftBarButtonItem = editButtonItem
        }
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.favorites.count
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        itemStore.moveFavorite(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Getting the favories and performing the correct segue based on the type
        let favorite: Favorite = itemStore.favorites[indexPath.row]
        
        if favorite.type == "place" {
            performSegue(withIdentifier: "favPlaceSegue", sender: indexPath.row)
        }
        else if favorite.type == "tour" {
            performSegue(withIdentifier: "favTourSegue", sender: indexPath.row)
        }
        else if favorite.type == "note" {
            performSegue(withIdentifier: "favNoteSegue", sender: indexPath.row)
        }
        else if favorite.type == "link" {
            let link = itemStore.links[indexPath.row]
            let svc = SFSafariViewController(url: URL(string:link.url)!)
            self.present(svc, animated: true, completion: nil)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the cell and the favorite and populating the appropriate cell based on type
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)    
        let fav = itemStore.favorites[indexPath.row]
        
        if fav.type == "tour" {
            let t: Tour = itemStore.getTour(uuid: fav.id)
            
            cell.textLabel?.text = t.title
            if t.type == "audio" {
                cell.imageView?.image = UIImage(named: "audio")
            } else {
                cell.imageView?.image = UIImage(named: "video")
            }
            
            tableView.rowHeight = CGFloat(50)
            
            return cell
        }
        else if fav.type == "place" {
            let cellplace = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
            let p: Place = itemStore.getPlace(uuid: fav.id)
            
            cellplace.CellLabel.text = p.title
            cellplace.CellImage.image = UIImage(named: p.image)
            
            tableView.rowHeight = CGFloat(100)
            
            return cellplace
        }
        else if fav.type == "note" {
            let cellNote = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
            let note: Note = itemStore.getNote(uuid: fav.id)
            
            cellNote.CellLabel.text = note.title
            cellNote.CellImage.image = itemStore.getImage(filename: note.image)
            tableView.rowHeight = CGFloat(75)
            return cellNote
        }
        else if fav.type == "link" {
            let cellLink = tableView.dequeueReusableCell(withIdentifier: "LinkCell", for: indexPath)
            let link: UserLink = itemStore.getLink(uuid: fav.id)
            
            cellLink.textLabel?.text = link.title
            cellLink.imageView?.image = UIImage(named: "links")
            tableView.rowHeight = CGFloat(50)
            return cellLink
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        // Setting up the alert controller for deleting a favorite
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
                self.itemStore.favorites.remove(at: indexPath.row)
                self.itemStore.syncData()
                
                // Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Prepare for segue depending on type of favorite selected
        if segue.identifier == "favPlaceSegue" {
            if let pvc = segue.destination as? PlaceViewController, let selectedRow = tableView.indexPathForSelectedRow?.row {
                let fav: Favorite = itemStore.favorites[selectedRow]
                pvc.itemStore = itemStore
                pvc.place = itemStore.getPlace(uuid: fav.id)
            }
        }
        if segue.identifier == "favTourSegue" {
            if let tvc = segue.destination as? TourViewController, let selectedRow = tableView.indexPathForSelectedRow?.row {
                let fav: Favorite = itemStore.favorites[selectedRow]
                tvc.itemStore = itemStore
                tvc.tour = itemStore.getTour(uuid: fav.id)
            }
        }
        if segue.identifier == "favNoteSegue" {
            if let nvc = segue.destination as? NoteViewController, let selectedRow = tableView.indexPathForSelectedRow?.row  {
                let fav: Favorite = itemStore.favorites[selectedRow]
                nvc.itemStore = itemStore
                nvc.note = itemStore.getNote(uuid: fav.id)
            } else {
                let nvc = segue.destination as? NoteViewController
                nvc?.itemStore = itemStore
            }
        }
    }
}

