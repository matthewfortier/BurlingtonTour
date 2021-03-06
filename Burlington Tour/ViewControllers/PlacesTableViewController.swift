//
//  PlacesTableViewController.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/19/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController {
    
    var itemStore: ItemStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering the place cell and setting the row height
        let nib = UINib.init(nibName: "PlaceCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "PlaceCell")
        tableView.rowHeight = CGFloat(100)
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
        let place = itemStore.places[indexPath.row]
        cell.CellLabel.text = place.title
        cell.CellImage.image = UIImage(named: place.image)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "placeDetailSegue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "placeDetailSegue" {
            if let pvc = segue.destination as? PlaceViewController, let selectedRow = tableView.indexPathForSelectedRow?.row {
                pvc.itemStore = itemStore
                pvc.place = itemStore.places[selectedRow]
            }
        }
    }
}
