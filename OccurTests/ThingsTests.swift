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
        let thing = Thing(name: "A thing")
        let repo = ThingsRepo()
        
        let savedThing = repo.save(thing)
        
        let found = repo.find(id: savedThing._id)
        
        XCTAssertEqual(savedThing, found)
    }
    
    func testAllReturnsAllTheThings() {
        let thing1 = Thing(name: "Thing 1")
        let thing2 = Thing(name: "Thing 2")
        
        let repo = ThingsRepo()
        
        let things = repo.save([thing1, thing2])
        
        XCTAssertEqual(repo.all(), things)
    }
    
    func testDeleteRemovesTheThing() {
        let thing1 = Thing(name: "Thing 1")
        let repo = ThingsRepo()
        let savedThing = repo.save(thing1)
        
        repo.delete(savedThing)
        
        XCTAssertEqual(repo.all(), [])
    }

    func testAddingAndDeleting() {
        let repo = ThingsRepo()
        let thing = repo.save(Thing(name:"Thing1"))
        let thing2 = repo.save(Thing(name:"Thing2"))

        repo.delete(thing)

        let thing3 = repo.save(Thing(name:"Thing3"))

        XCTAssertEqual(repo.all(), [thing2, thing3])
    }
    
    func testAddingAnOccurance() {
        let thing1 = Thing(name: "Thing 1")
        let repo = ThingsRepo()
        let occurrences = OccurrenceRepo()
        
        let savedThing = repo.save(thing1)
        
        let occurrence = Occurrence(thing: savedThing)
        let savedOccurrence = occurrences.save(occurrence)
        
        XCTAssertEqual(occurrences.forThing(savedThing), [savedOccurrence])
    }

    func testSavingAThingAgain() {
        let repo = ThingsRepo()
        let thing = repo.save(Thing(name:"Thing1"))

        let changedThing = thing.setName(name: "something else")

        let _ = repo.save(changedThing)

        XCTAssertEqual(repo.all(), [changedThing])
    }

    func testUpdateDoesNotChangeOrder() {
        let repo = ThingsRepo()
        let thing = repo.save(Thing(name: "Thing1"))
        let thing2 = repo.save(Thing(name: "Thing2"))

        XCTAssertEqual([thing, thing2], repo.all())

        let changedThing = repo.save(Thing(name: "Something Else", id: thing._id))

        XCTAssertEqual(repo.all(), [changedThing, thing2])
    }
}
