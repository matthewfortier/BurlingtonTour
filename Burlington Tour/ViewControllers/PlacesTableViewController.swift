//
//  PlacesTableViewController.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/19/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController {
    
    var itemStore: ItemStore = ItemStore()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadPlaces()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "standardCell", for: indexPath)
        let place = itemStore.places[indexPath.row]
        cell.textLabel?.text = place.title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "placeDetailSegue" {
            if let pvc = segue.destination as? PlaceViewController, let selectedRow = tableView.indexPathForSelectedRow?.row {
                pvc.image = itemStore.places[selectedRow].image
                pvc.body = itemStore.places[selectedRow].body
                pvc.navTitle = itemStore.places[selectedRow].title
                pvc.lat = itemStore.places[selectedRow].lat
                pvc.lon = itemStore.places[selectedRow].lon
            }
        }
    }
    
    func loadPlaces() {
        var place : Place
        if let path = Bundle.main.path(forResource: "Places", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                for item in 0..<Array(dict).count {
                    if let p = dict[String(item)] as? [String:AnyObject],
                        let title = p["title"] as? String,
                        let image = p["image"] as? String,
                        let body = p["body"] as? String,
                        let lat = p["lat"] as? Float,
                        let lon = p["lon"] as? Float {
                        
                        place = Place(title: title, body: body, image: image, lat: lat, lon: lon)
                        itemStore.places.append(place)
                    }
                }
            }
        }
    }
}
