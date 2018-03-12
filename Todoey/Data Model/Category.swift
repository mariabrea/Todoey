//
//  Category.swift
//  Todoey
//
//  Created by Maria Martinez on 3/12/18.
//  Copyright © 2018 Maria Martinez Guzman. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
