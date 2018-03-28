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
    var links: [UserLink] = []
    var favoritesArray: [AnyObject] = []
    //var numFavorites = 2
    
    init() {
        loadPlaces()
        loadTours()
        loadUserData()
        //fillFavorites()
    }
    
    @discardableResult func createNote(title: String, image: UIImage, body: String, fav: Bool) -> Note {
        let newNote = Note(order: 0, title: title, file: image, body: body, fav: fav)
        notes.append(newNote)
        syncData()
        return newNote
    }
    
    func moveNote(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedItem = notes[fromIndex]
        notes.remove(at: fromIndex)
        notes.insert(movedItem, at: toIndex)
        
        syncData()
    }
    func moveFavorite(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can re-insert it
        let movedItem = favoritesArray[fromIndex]
        
        // Remove item from array
        favoritesArray.remove(at: fromIndex)
        
        // Insert item in array at new location
        favoritesArray.insert(movedItem, at: toIndex)
        
        //syncFavorites()
        
    }

    func updateNote(original: Note, title: String, image: UIImage, body: String, fav: Bool) -> Note {
        var note: Note!
        
        if let index = notes.index(of: original) {
            notes[index].title = title
            notes[index].image = image
            notes[index].body = body
            notes[index].fav = fav
            note = notes[index]
        }
        syncData()
        
        return note
    }
    
    func removeNote(_ note: Note) {
        if let index = notes.index(of: note) {
            notes.remove(at: index)
        }
        syncData()
    }
    
    @discardableResult func createLink(title: String, url: String) -> UserLink {
        let newLink = UserLink(order: 0, title: title, url: url)
        links.append(newLink)
        syncData()
        return newLink
    }
    
    func moveLink(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedItem = links[fromIndex]
        links.remove(at: fromIndex)
        links.insert(movedItem, at: toIndex)
        
        syncData()
    }
    
    func removeLink(_ link: UserLink) {
        if let index = links.index(of: link) {
            links.remove(at: index)
        }
        
        syncData()
    }
    
    func loadUserData() {
        if UserDefaults.standard.object(forKey: "links") != nil {
            let decoded  = UserDefaults.standard.object(forKey: "links") as! Data
            links = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [UserLink]
        }
    
        if UserDefaults.standard.object(forKey: "notes") != nil {
            let decoded  = UserDefaults.standard.object(forKey: "notes") as! Data
            notes = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Note]
        }
    }

    func removeFavorite(row : Int) {
       
        favoritesArray.remove(at: row)
        //syncFavorites()
    }
    
    func syncData() {
        var encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: links)
        UserDefaults.standard.set(encodedData, forKey: "links")
        UserDefaults.standard.synchronize()
        
        encodedData = NSKeyedArchiver.archivedData(withRootObject: notes)
        UserDefaults.standard.set(encodedData, forKey: "notes")
        UserDefaults.standard.synchronize()
        
    }

//Favorites saving and loading does not function
//    func loadFavorites() {
//        //var tempPlaces = [Int : Place]()
//        if UserDefaults.standard.object(forKey: "favorites") != nil {
//            let result = UserDefaults.standard.value(forKey: "favorites")
//            print(result!)
//
//        }
//    }
    


     //Favorites saving and loading does not function.
//    func syncFavorites() {
//        
//        
//        var placeFav = [Int: Place]()
//        for item in 0...favoritesArray.count - 1{
//            switch favoritesArray[item] {
//            case is Place:
//                let c : Place = favoritesArray[item] as! Place
//                placeFav.updateValue(c, forKey: item)
//            case is Tour:
//                print("tour")
//
//            default:
//                print("O SHIT")
//            }
//        }
//        let nsDict: NSDictionary = placeFav as NSDictionary
//        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: nsDict)
//            UserDefaults.standard.set(encodedData, forKey: "favorites")
//            UserDefaults.standard.synchronize()
//        
//    }

    
    //********** Not Required - fakefilldata ************************
    //We can atleast fill an array with whatever we want to put here.
//    func fillFavorites(){
//        let favoritePlace : AnyObject = places[0] as AnyObject
//        let favoriteTour : AnyObject = tours[0] as AnyObject
//        favoritesArray.append(favoritePlace)
//        favoritesArray.append(favoriteTour)
//      print (tours[0].title)
//        if (favoritesArray[1] is Tour){
//            print("Hey check that out")
//            let c : Tour = favoritesArray[1] as! Tour
//            print(c.title)
//            //print(favoritesArray[0].title)
//        }else{
//            print("uhoh")
//        }
//
//   }

    func addFavorite(newFav: AnyObject) {
        favoritesArray.append(newFav)
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
                        let type = p["type"] as? String,
                        let fav = p["fav"] as? Bool{
                        
                        tour = Tour(order: order, title: title, file: file, type: type, fav: fav)
                        tours.append(tour)
                    }
                }
            }
        }
    }
}
