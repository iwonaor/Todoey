//
//  Category.swift
//  Todoey
//
//  Created by Iwona Orocz on 25/08/2018.
//  Copyright © 2018 Iwona Orocz. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
   @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
