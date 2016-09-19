//
//  Thing.swift
//  Occur
//
//  Created by Dorian Scheidt on 2016-09-17.
//  Copyright © 2016 Dorian Listens. All rights reserved.
//

import Foundation

struct Thing: Saveable {
    let name: String
    let _id: SaveableID
    
    var description: String {
        return name
    }

    init(name: String = "a new thing", id: SaveableID = .invalid) {
        self.name = name
        self._id = id
    }

    func setID(id: SaveableID) -> Thing {
        return Thing(name: name, id: id)
    }

    func setName(name: String) -> Thing {
        return Thing(name: name, id: _id)
    }
}

func ==(rhs: Thing, lhs: Thing) -> Bool {
    return rhs._id == lhs._id && rhs.name == lhs.name
}

struct Occurrence: Saveable {
    let thingID: SaveableID
    let _id: SaveableID
    let date: Date
    
    init(thing: Thing) {
        self.init(thingID: thing._id)
    }
    
    init(thingID: SaveableID, id: SaveableID = .invalid, date: Date = Date()) {
        self.thingID = thingID
        self._id = id
        self.date = date
    }
    
    func setID(id: SaveableID) -> Occurrence {
        return Occurrence(thingID: thingID, id: id)
    }
}

func ==(rhs: Occurrence, lhs: Occurrence) -> Bool {
    return rhs._id == lhs._id && rhs.thingID == lhs.thingID
}

protocol Saveable: Equatable {
    var _id: SaveableID { get }
    func setID(id: SaveableID) -> Self
}

enum SaveableID: Equatable {
    case invalid
    case valid(Int)
}

func ==(rhs: SaveableID, lhs: SaveableID) -> Bool {
    switch rhs {
    case .invalid: return lhs == .invalid
    case .valid(let val):
        switch lhs {
        case .invalid: return false
        case .valid(let x): return val == x
        }
    }
}

class Repository<T> where T: Saveable {
    var allTheThings: [T] = []
    var thingCounter = 0

    init() {}

    func save(_ thing: T) -> T {
        let thingToSave = prepareToSave(thing)

        if let idx = allTheThings.index(where: { $0._id == thingToSave._id }) {
            allTheThings.remove(at: idx)
            allTheThings.insert(thingToSave, at: idx)
        } else {
            allTheThings.append(thingToSave)
        }

        return thingToSave
    }

    func save(_ things: [T]) -> [T] {
        return things.map(save)
    }
    
    private func prepareToSave(_ thing: T) -> T {
        switch thing._id {
        case .valid(_):
            return thing
        case .invalid:
            return thing.setID(id: generateID())
        }
    }

    private func generateID() -> SaveableID {
        thingCounter += 1
        return .valid(thingCounter)
    }
    
    func delete(_ thing: T) {
        if let idx = allTheThings.index(of: thing) {
            allTheThings.remove(at: idx)
        }
    }
    
    func find(id: SaveableID) -> T? {
        return allTheThings.first { $0._id == id }
    }
    
    func all() -> [T] {
        return allTheThings
    }
}

class ThingsRepo: Repository<Thing> {}

class OccurrenceRepo: Repository<Occurrence> {
    func forThing(_ thing: Thing) -> [Occurrence] {
        return allTheThings.filter { $0.thingID == thing._id }
    }
}
