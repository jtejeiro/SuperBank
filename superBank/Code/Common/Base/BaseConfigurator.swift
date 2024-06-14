//
//  BaseConfigurator.swift
//  superBank
//
//  Created by JT on 09/05/2020.
//  Copyright © 2020 JT. All rights reserved.
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
    
    static func ConfigGlobalApareance() -> UINavigationBarAppearance{
        //        UINavigationBar.appearance().isTranslucent = true
        //        UINavigationBar.appearance().barTintColor = .red
        //
        //        UINavigationBar.appearance().backgroundColor = .red
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .red
        appearance.shadowColor = .clear
        UINavigationBar.appearance().tintColor = .white
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        return appearance
    }

    
}
