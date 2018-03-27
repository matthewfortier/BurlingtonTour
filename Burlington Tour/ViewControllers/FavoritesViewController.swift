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
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //tableView.rowHeight = CGFloat(100)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "tourDetailSegue", sender: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        let fav = itemStore.favoritesArray[indexPath.row]
        
        switch fav {
            case is Tour:
                let c : Tour = fav as! Tour
                cell.textLabel?.text = c.title
                print("here")
            case is Place:
                let c : Place = fav as! Place
                cell.textLabel?.text = c.title
                print("here")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tourDetailSegue" {
            if let tvc = segue.destination as? TourViewController, let selectedRow = tableView.indexPathForSelectedRow?.row {
                tvc.tourTitle = itemStore.tours[selectedRow].title
                tvc.file = itemStore.tours[selectedRow].file
            }
        }
    }
 }
