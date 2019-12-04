//
//  data.swift
//  Todoey
//
//  Created by Jamie on 02/12/2019.
//  Copyright © 2019 Olympus KeyMed. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = "" // using dynamic to monitor the change in real time ofr a new realm property
    @objc dynamic var age: Int = 0
}
