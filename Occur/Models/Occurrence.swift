//
//  Occurrence.swift
//  Occur
//
//  Created by Dorian Scheidt on 2016-09-20.
//  Copyright © 2016 Dorian Listens. All rights reserved.
//

import Foundation

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

func == (rhs: Occurrence, lhs: Occurrence) -> Bool {
    return rhs._id == lhs._id && rhs.thingID == lhs.thingID
}
