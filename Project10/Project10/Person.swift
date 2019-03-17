//
//  Person.swift
//  Project10
//
//  Created by Brad Thurlow on 16/3/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
