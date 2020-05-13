//
//  BasesPagerModel.swift
//  superBank
//
//  Created by JT on 12/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import Foundation

struct BasesPagerModel: Codable  {
    var offset, limit, total, count: Int
    var results: [CharactersListResponse]
}
