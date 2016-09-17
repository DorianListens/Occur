//
//  Thing.swift
//  Occur
//
//  Created by Dorian Scheidt on 2016-09-17.
//  Copyright © 2016 Dorian Listens. All rights reserved.
//

import Foundation

struct Thing: Equatable {
    let name: String
    let _id: Int
    
    var description: String {
        return name
    }
}

func ==(rhs: Thing, lhs: Thing) -> Bool {
    return rhs._id == lhs._id && rhs.name == lhs.name
}

struct Occurence {
    let thingID: Int
}

class ThingsRepo {
    private var allTheThings: [Thing] = []
    init() {
    }
    
    func save(thing: Thing) {
        allTheThings.append(thing)
    }
    
    func save(things: [Thing]) {
        things.forEach(save)
    }
    
    func delete(thing: Thing) {
        if let idx = allTheThings.index(of: thing) {
            allTheThings.remove(at: idx)
        }
    }
    
    func find(id: Int) -> Thing? {
        return allTheThings.first { $0._id == id }
    }
    
    func all() -> [Thing] {
        return allTheThings
    }
}
