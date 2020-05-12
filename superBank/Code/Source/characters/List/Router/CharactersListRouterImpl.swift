//
//  CharactersListRouterImpl.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//
import Foundation
import UIKit


class CharactersListRouterImpl {
    
    var mainRouter:UIViewController
    
    init(mainRouter: UIViewController) {
        self.mainRouter = mainRouter
    }
}
 // MARK: - CharactersListRouterImpl
extension CharactersListRouterImpl: CharactersListRouter  {
    
    func goBack() {
        mainRouter.navigationController?.popViewController(animated: true)
    }
    
    func goCharactersDeteils(id:String){
        let viewController = CharactersDetailsConfigurator.createModule(charactersID: id)
        mainRouter.navigationController?.pushViewController(viewController, animated: true)
    }
}
