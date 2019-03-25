//
//  Pics.swift
//  consolidationDay5
//
//  Created by Brad Thurlow on 25/3/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import Foundation

class CameraPics: Codable {
    var file: String
    var image: String
    
    init(file: String, image: String) {
        self.file = file
        self.image = image
    }
}
