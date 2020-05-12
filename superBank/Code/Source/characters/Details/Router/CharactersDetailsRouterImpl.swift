//
//  CharactersDetailsRouterImpl.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//
import Foundation
import UIKit

class CharactersDetailsRouterImpl:BaseRouter {
    
    var mainRouter:UIViewController
    
    init(mainRouter: UIViewController) {
        self.mainRouter = mainRouter
    }
}
 // MARK: - CharactersDetailsRouterImpl
extension CharactersDetailsRouterImpl: CharactersDetailsRouter  {
    
    func goBack() {
        mainRouter.navigationController?.popViewController(animated: true)
    }
    
    func goOpenWeb(urlString:String) {
        if let link = URL(string: urlString ) {
            self.openWebUrl(link)
        }
    }
    
    
}
