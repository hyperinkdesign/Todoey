//
//  Category.swift
//  Todoey
//
//  Created by Jamie on 02/12/2019.
//  Copyright © 2019 Olympus KeyMed. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>() // the forward relationship
    // the inverse relationship
    
}
