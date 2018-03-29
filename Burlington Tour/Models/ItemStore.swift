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
    var favorites: [Favorite] = []
    //var numFavorites = 2
    
    init() {
        loadPlaces()
        loadTours()
        loadUserData()
        //fillFavorites()
    }
    
    @discardableResult func createNote(title: String, image: UIImage, body: String) -> Note {
        let newNote = Note(order: 0, title: title, file: image, body: body)
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
    
    func updateNote(original: Note, title: String, image: UIImage, body: String) -> Note {
        var note: Note!
        
        if let index = notes.index(of: original) {
            notes[index].title = title
            notes[index].image = image
            notes[index].body = body
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
        
        if UserDefaults.standard.object(forKey: "favorites") != nil {
            let decoded  = UserDefaults.standard.object(forKey: "favorites") as! Data
            favorites = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Favorite]
        }
    }
    
    func syncData() {
        var encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: links)
        UserDefaults.standard.set(encodedData, forKey: "links")
        UserDefaults.standard.synchronize()
        
        encodedData = NSKeyedArchiver.archivedData(withRootObject: notes)
        UserDefaults.standard.set(encodedData, forKey: "notes")
        UserDefaults.standard.synchronize()
        
        encodedData = NSKeyedArchiver.archivedData(withRootObject: favorites)
        UserDefaults.standard.set(encodedData, forKey: "favorites")
        UserDefaults.standard.synchronize()
    }
    
    func getTour(uuid: String) -> Tour {
        var tour: Tour!
        for t in tours {
            if t.id == uuid {
                tour = t
                break
            }
        }
        return tour
    }
    
    func getNote(uuid: String) -> Note {
        var note: Note!
        for n in notes {
            if n.id == uuid {
                note = n
                break
            }
        }
        return note
    }
    
    func getPlace(uuid: String) -> Place {
        var place: Place!
        for p in places {
            if p.id == uuid {
                place = p
            }
        }
        return place
    }
    
    func isFavorite(uuid: String) -> Bool {
        for f in favorites {
            if f.id == uuid {
                return true
            }
        }
        return false
    }

    @objc func addFavorite(uuid: String, type: String) {
        favorites.append(Favorite(id: uuid, type: type))
        syncData()
    }
    
    @objc func removeFavorite(uuid : String) {
        if let i = favorites.index(where: { $0.id == uuid }) {
            favorites.remove(at: i)
        }
        syncData()
    }
    
    func moveFavorite(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedItem = favorites[fromIndex]
        favorites.remove(at: fromIndex)
        favorites.insert(movedItem, at: toIndex)
        
        syncData()
    }

    
    func loadPlaces() {
        var place : Place
        if let path = Bundle.main.path(forResource: "Places", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                for item in 0..<Array(dict).count {
                    if let p = dict[String(item)] as? [String:AnyObject],
                        let id = p["id"] as? String,
                        let order = p["order"] as? Int,
                        let title = p["title"] as? String,
                        let image = p["image"] as? String,
                        let body = p["body"] as? String,
                        let lat = p["lat"] as? Float,
                        let lon = p["lon"] as? Float{
                        
                        place = Place(id: id, order: order, title: title, body: body, image: image, lat: lat, lon: lon)
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
                        let id = p["id"] as? String,
                        let order = p["order"] as? Int,
                        let title = p["title"] as? String,
                        let file = p["file"] as? String,
                        let type = p["type"] as? String {
                        
                        tour = Tour(id: id, order: order, title: title, file: file, type: type)
                        tours.append(tour)
                    }
                }
            }
        }
    }
}
