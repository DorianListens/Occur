//
//  Thing.swift
//  Occur
//
//  Created by Dorian Scheidt on 2016-09-17.
//  Copyright © 2016 Dorian Listens. All rights reserved.
//

import Foundation
import UIKit

struct Thing: Saveable {
    let name: String
    let _id: SaveableID
    let image: UIImage?

    var description: String {
        return name
    }

    init(name: String = "a new thing", id: SaveableID = .invalid, image: UIImage? = nil) {
        self.name = name
        self._id = id
        self.image = image
    }

    func setID(id: SaveableID) -> Thing {
        return Thing(name: name, id: id, image: image)
    }

    func setName(name: String) -> Thing {
        return Thing(name: name, id: _id, image: image)
    }

    func setImage(image: UIImage?) -> Thing {
        return Thing(name: name, id: _id, image: image)
    }
}

func == (rhs: Thing, lhs: Thing) -> Bool {
    return rhs._id == lhs._id && rhs.name == lhs.name
}
