//
//  BaseRouter.swift
//  superBank
//
//  Created by Jaime Tejeiro on 12/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//
import UIKit
import Foundation

class BaseRouter {
    
    func openWebUrl(_ url: URL) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
