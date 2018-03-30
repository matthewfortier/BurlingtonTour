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

    init() {
        loadPlaces()
        loadTours()
        loadUserData()
    }
    
    func loadFirstLinks() {
        links.append(UserLink(title: "Dealer", url: "https://www.dealer.com/"))
        links.append(UserLink(title: "MyWebGrocier", url: "http://mywebgrocer.com/"))
        links.append(UserLink(title: "Church Street", url: "https://www.churchstmarketplace.com/"))
    }

    @discardableResult func createNote(title: String, image: String, body: String) -> Note {
        let newNote = Note(title: title, file: image, body: body)
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

    @discardableResult func updateNote(original: Note, title: String, image: String, body: String) -> Note {
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
        removeFavorite(uuid: note.id)

        if let index = notes.index(of: note) {
            notes.remove(at: index)
        }
        syncData()
    }

    @discardableResult func createLink(title: String, url: String) -> UserLink {
        let newLink = UserLink(title: title, url: url)
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
        removeFavorite(uuid: link.id)

        if let index = links.index(of: link) {
            links.remove(at: index)
        }
        syncData()
    }

    func loadUserData() {
        if UserDefaults.standard.object(forKey: "links") != nil {
            let decoded = UserDefaults.standard.object(forKey: "links") as! Data
            links = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [UserLink]
        }

        if UserDefaults.standard.object(forKey: "notes") != nil {
            let decoded = UserDefaults.standard.object(forKey: "notes") as! Data
            notes = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Note]
        }

        if UserDefaults.standard.object(forKey: "favorites") != nil {
            let decoded = UserDefaults.standard.object(forKey: "favorites") as! Data
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

    
    func getLink(uuid: String) -> UserLink {
        var link: UserLink!
        for n in links {
            if n.id == uuid {
                link = n
                break
            }
        }
        return link
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
        if (type == "link"){
            for i in 0...favorites.count {
                if (uuid == favorites[i].id) {
                    return
                }
                else{
                    favorites.append(Favorite(id: uuid, type: type))
                }
            }
        }else {
            favorites.append(Favorite(id: uuid, type: type))
        }
        syncData()
    }

    @objc func removeFavorite(uuid: String) {
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
        var place: Place
        if let path = Bundle.main.path(forResource: "Places", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                for item in 0..<Array(dict).count {
                    if let p = dict[String(item)] as? [String: AnyObject],
                        let id = p["id"] as? String,
                        let title = p["title"] as? String,
                        let image = p["image"] as? String,
                        let body = p["body"] as? String,
                        let lat = p["lat"] as? Float,
                        let lon = p["lon"] as? Float {

                        place = Place(id: id, title: title, body: body, image: image, lat: lat, lon: lon)
                        places.append(place)
                    }
                }
            }
        }
    }

    func loadTours() {
        var tour: Tour
        if let path = Bundle.main.path(forResource: "Tours", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                for item in 0..<Array(dict).count {
                    if let p = dict[String(item)] as? [String: AnyObject],
                        let id = p["id"] as? String,
                        let title = p["title"] as? String,
                        let file = p["file"] as? String,
                        let type = p["type"] as? String {

                        tour = Tour(id: id, title: title, file: file, type: type)
                        tours.append(tour)
                    }
                }
            }
        }
    }

    // Function borrowed from https://gist.github.com/marcelvoss/cf437ec5ef1d717c675dc9b0f35aa4cd
    func uniqueFilename(withPrefix prefix: String? = nil) -> String {
        let uniqueString = ProcessInfo.processInfo.globallyUniqueString

        if prefix != nil {
            return "\(prefix!)-\(uniqueString)"
        }

        return uniqueString
    }

    // Functions borrowed from https://iosdevcenters.blogspot.com/2016/04/save-and-get-image-from-document.html
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func saveImageDocumentDirectory(image: UIImage) -> String {
        let filename = uniqueFilename() + ".jpg"
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(filename)
        //let image = UIImage(named: filename + ".jpg")
        print(paths)
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)

        return filename
    }

    func getImage(filename: String) -> UIImage {
        var image: UIImage!
        let fileManager = FileManager.default
        let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(filename)
        if fileManager.fileExists(atPath: imagePath) {
            image = UIImage(contentsOfFile: imagePath)!
        } else {
            return UIImage(named: "")!
        }
        return image
    }
}
