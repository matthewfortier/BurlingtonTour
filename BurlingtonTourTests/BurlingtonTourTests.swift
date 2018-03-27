//
//  BurlingtonTourTests.swift
//  BurlingtonTourTests
//
//  Created by Matthew Fortier on 3/27/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import XCTest
@testable import Burlington_Tour

class BurlingtonTourTests: XCTestCase {
    
    var store: ItemStore!
    
    override func setUp() {
        super.setUp()
        
        store = ItemStore()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        store = nil
    }
    
    func testMoveNoteTableViewCell() {
        let currentIndex = 0
        let newIndex = 1
        
        let image: UIImage = UIImage(named: "church.jpg")!
        
        store.createNote(title: "Test1", image: image, body: "Some string")
        store.createNote(title: "Test2", image: image, body: "Some string 2")
        
        let note = store.notes[currentIndex]
        
        store.moveNote(from: currentIndex, to: newIndex)
        
        XCTAssert(store.notes[newIndex].title == note.title)
    }
    
    func testDeleteNoteTableViewCell() {
        let image: UIImage = UIImage(named: "church.jpg")!
        let note = store.createNote(title: "Test1", image: image, body: "Some string")
        
        XCTAssert(store.notes.index(of: note) != nil)
        store.removeNote(note)
        XCTAssert(store.notes.index(of: note) == nil)
    }
    
}
