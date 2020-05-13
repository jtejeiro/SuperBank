//
//  UIBarButtonItem+Extension.swift
//  superBank
//
//  Created by JT on 11/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(title: String = "") {
        self.init()
        self.title = title
    }
}
