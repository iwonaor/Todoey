//
//  Item.swift
//  Todoey
//
//  Created by Iwona Orocz on 25/08/2018.
//  Copyright © 2018 Iwona Orocz. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    @objc dynamic var dateCreated: Date?
}
