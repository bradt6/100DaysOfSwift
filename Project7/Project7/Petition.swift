//
//  Petition.swift
//  Project7
//
//  Created by Brad Thurlow on 6/3/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
