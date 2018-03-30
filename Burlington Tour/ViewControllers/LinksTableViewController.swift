//
//  LinksTableViewController.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/27/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit
import SafariServices

class LinksTableViewController: UITableViewController {

    var itemStore: ItemStore!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        if itemStore.links.count > 0 {
            navigationItem.leftBarButtonItem = editButtonItem
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createLink(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Link", message: "Add title and link below", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Title..."
        }
        alert.addTextField { (textField) in
            textField.text = "http://"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let title = alert?.textFields![0].text
            let url = alert?.textFields![1].text
            
            if title != nil && url != nil {
                self.itemStore.createLink(title: title!, url: url!)
                self.tableView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { [weak alert] (_) in
            // Do nothing
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // Update the model
        itemStore.moveLink(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.links.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StandardCell", for: indexPath)
        let link = itemStore.links[indexPath.row]
        
        cell.textLabel?.text = link.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "createNoteSegue", sender: indexPath.row)
        let link = itemStore.links[indexPath.row]
        let svc = SFSafariViewController(url: URL(string:link.url)!)
        self.present(svc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.links[indexPath.row]
            
            
            let title = "Delete or Favorite \(item.title)?"
            let message = "Choose one action?"
            
            
            
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .actionSheet)
            
            ac.addAction(UIAlertAction(title: "Favorite", style: .default, handler: {(alert: UIAlertAction!) in self.itemStore.addFavorite(uuid: self.itemStore.links[indexPath.row].id, type: "link")}))
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                             handler: { (action) -> Void in
                                                // Remove the item from the store
                                                self.itemStore.removeLink(item)
                                                
                                                // Also remove that row from the table view with an animation
                                                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
           
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
        
        
    }
 

    @IBAction func unwindToTableView(segue:UIStoryboardSegue) {
        tableView.reloadData()
    }
}
