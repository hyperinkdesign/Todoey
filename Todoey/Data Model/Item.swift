//
//  Item.swift
//  Todoey
//
//  Created by Jamie on 14/10/2019.
//  Copyright © 2019 Olympus KeyMed. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items") // define the inverse relationship links back to the parent gategory
}
//
//// this class has been replaced with the core data model
//class t_Item: Codable { // conforms to both Encodable, Decodable protacols
//    var t_title: String = ""
//    var t_done: Bool = false
//}


