//
//  BaseConfigurator.swift
//  superBank
//
//  Created by Jaime Tejeiro on 09/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import Foundation
import UIKit

class BaseConfigurator {

    var viewController: UIViewController {
        return createViewController()
    }
    
    
    private func createViewController() -> UIViewController {
        let view = CharactersListConfigurator.createModule()
    return view
    }
    
    static func ConfigGlobalApareance(){
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().barTintColor = .red
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }

    
}
