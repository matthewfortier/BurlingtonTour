//
//  ToursTableViewController.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/20/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ToursTableViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    var playerviewcontroller = AVPlayerViewController()
    var playerview = AVPlayer ()

    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.rowHeight = CGFloat(100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.tours.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "tourDetailSegue", sender: indexPath.row)
        
        let file = itemStore.tours[indexPath.row].file
        
        guard let path = Bundle.main.path(forAuxiliaryExecutable: file) else {
            debugPrint("video.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TourCell", for: indexPath)
        let tour = itemStore.tours[indexPath.row]
        
        cell.textLabel?.text = tour.title
        if tour.type == "audio" {
            cell.imageView?.image = UIImage(named: "audio")
        } else {
            cell.imageView?.image = UIImage(named: "video")
        }
        
        return cell
    }
}
