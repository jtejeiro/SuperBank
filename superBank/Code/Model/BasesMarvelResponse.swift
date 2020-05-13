//
//  BasesMarvelResponse.swift
//  superBank
//
//  Created by JT on 10/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//


import UIKit
import Foundation

struct BasesMarvelResponse:Codable {
    var code: Int?
    var status: String?
    var data:BasesPagerModel
}
