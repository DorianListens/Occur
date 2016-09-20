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

func == (rhs: Thing, lhs: Thing) -> Bool {
    return rhs._id == lhs._id && rhs.name == lhs.name
}
