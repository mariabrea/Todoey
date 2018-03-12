//
//  Item.swift
//  Todoey
//
//  Created by Maria Martinez on 3/12/18.
//  Copyright © 2018 Maria Martinez Guzman. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
