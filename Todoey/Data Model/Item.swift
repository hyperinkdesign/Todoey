//
//  Item.swift
//  Todoey
//
//  Created by Jamie on 14/10/2019.
//  Copyright © 2019 Olympus KeyMed. All rights reserved.
//

import Foundation


class Item: Codable { // conforms to both Encodable, Decodable protacols
    var title: String = ""
    var done: Bool = false
}
