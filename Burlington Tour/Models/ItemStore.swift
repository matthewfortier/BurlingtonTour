//
//  ItemsStore.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/19/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import Foundation
import UIKit

class ItemStore {
    var places: [Place] = []
    var tours: [Tour] = []
    var notes: [Note] = []
    var favoritesArray: [AnyObject] = []
    //var numFavorites = 2
    
    init() {
        loadPlaces()
        loadTours()
<<<<<<< HEAD
        loadNotes()
    }
    
    @discardableResult func createNote(title: String, image: UIImage, body: String) -> Note {
        let newNote = Note(order: 0, title: title, file: image, body: body)
        
        notes.append(newNote)
        UserDefaults.standard.set(notes, forKey: "notes")
        
        return newNote
    }
    
    func loadNotes() {
        if UserDefaults.standard.object(forKey: "notes") != nil {
            notes = UserDefaults.standard.array(forKey: "notes") as! [Note]
        }
=======
        fillFavorites()
    }
    //We can atleast fill an array with whatever we want to put here.
    func fillFavorites(){
        let favoritePlace : AnyObject = places[0] as AnyObject
        let favoriteTour : AnyObject = tours[0] as AnyObject
        favoritesArray.append(favoritePlace)
        favoritesArray.append(favoriteTour)
//      /*  print (tours[0].title)
//        if (favoritesArray[1] is Tour){
//            print("Hey check that out")
//            let c : Tour = favoritesArray[1] as! Tour
//            print(c.title)
//            print(favoritesArray[0].title)
//        }else{
//            print("uhoh")
//        }
//        */
   }
    
    func addFavorite(newFav: AnyObject) {
        favoritesArray.append(newFav)
>>>>>>> 2be676522cbbfd1f55da0c4b7246f54a3720957f
    }
    
    func loadPlaces() {
        var place : Place
        if let path = Bundle.main.path(forResource: "Places", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                for item in 0..<Array(dict).count {
                    if let p = dict[String(item)] as? [String:AnyObject],
                        let order = p["order"] as? Int,
                        let title = p["title"] as? String,
                        let image = p["image"] as? String,
                        let body = p["body"] as? String,
                        let lat = p["lat"] as? Float,
                        let lon = p["lon"] as? Float,
                        let fav = p["fav"] as? Bool{
                        
                        place = Place(order: order, title: title, body: body, image: image, lat: lat, lon: lon, fav: fav)
                        if (fav == true){
                            let fave : AnyObject = place as AnyObject
                            favoritesArray.append(fave)
                        }
                        places.append(place)
                    }
                }
            }
        }
    }
    
    func loadTours() {
        var tour : Tour
        if let path = Bundle.main.path(forResource: "Tours", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                for item in 0..<Array(dict).count {
                    if let p = dict[String(item)] as? [String:AnyObject],
                        let order = p["order"] as? Int,
                        let title = p["title"] as? String,
                        let file = p["file"] as? String,
                        let type = p["type"] as? String {
                        
                        tour = Tour(order: order, title: title, file: file, type: type)
                        tours.append(tour)
                    }
                }
            }
        }
    }
}
