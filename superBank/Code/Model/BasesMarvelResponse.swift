//
//  BasesMarvelResponse.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//


import UIKit
import Foundation

struct BasesMarvelResponse:Codable {
    var code: Int?
    var status: String?
    var data:BasesPagerModel
}

struct BasesPagerModel: Codable  {
    var offset, limit, total, count: Int
    var results: [CharactersListResponse]
}



