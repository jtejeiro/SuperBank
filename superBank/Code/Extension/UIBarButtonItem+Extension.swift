//
//  UIBarButtonItem+Extension.swift
//  superBank
//
//  Created by Jaime Tejeiro on 11/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(title: String = "") {
        self.init()
        self.title = title
    }
}
