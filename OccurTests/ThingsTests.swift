//
//  ThingsTests.swift
//  Occur
//
//  Created by Dorian Scheidt on 2016-09-17.
//  Copyright © 2016 Dorian Listens. All rights reserved.
//

import XCTest
@testable import Occur

class ThingsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetThingReturnsThingForTheID() {
        let id = 1
        let thing = Thing(name: "A thing", _id: id)
        let repo = ThingsRepo()
        
        repo.save(thing: thing)
        
        let found = repo.find(id: id)
        
        XCTAssertEqual(thing, found)
    }
    
    func testAllReturnsAllTheThings() {
        let thing1 = Thing(name: "Thing 1", _id: 1)
        let thing2 = Thing(name: "THing 2", _id: 2)
        
        let repo = ThingsRepo()
        
        repo.save(things: [thing1, thing2])
        
        XCTAssertEqual(repo.all(), [thing1, thing2])
    }
    
    func testDeleteRemovesTheThing() {
        let thing1 = Thing(name: "Thing 1", _id: 1)
        let repo = ThingsRepo()
        repo.save(thing: thing1)
        
        repo.delete(thing: thing1)
        
        XCTAssertEqual(repo.all(), [])
    }
}
