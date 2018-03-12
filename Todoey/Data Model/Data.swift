//
//  Data.swift
//  Todoey
//
//  Created by Maria Martinez on 3/12/18.
//  Copyright © 2018 Maria Martinez Guzman. All rights reserved.
//

import Foundation
import RealmSwift

class Data : Object {
    //dynamic means that realm monitors for changes at runtime
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
}
