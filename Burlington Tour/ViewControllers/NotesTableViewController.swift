//
//  NotesTableTableViewController.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/22/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        let nib = UINib.init(nibName: "PlaceCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "PlaceCell")
        tableView.rowHeight = CGFloat(100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
        let note = itemStore.notes[indexPath.row]
        
        cell.CellLabel.text = note.title
        cell.CellImage.image = note.image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "createNoteSegue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNoteSegue" {
            if let nvc = segue.destination as? NoteViewController, let selectedRow = tableView.indexPathForSelectedRow?.row  {
                nvc.itemStore = itemStore
                nvc.body = itemStore.notes[selectedRow].body
                nvc.image = itemStore.notes[selectedRow].image
                nvc.noteTitle = itemStore.notes[selectedRow].title
            }
        }
    }
    
    @IBAction func unwindToTableView(segue:UIStoryboardSegue) {
        tableView.reloadData()
    }
}
