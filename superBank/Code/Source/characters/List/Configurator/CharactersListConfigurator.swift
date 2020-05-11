//
//  CharactersListConfigurator.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import UIKit
import Foundation

@objc final class CharactersListConfigurator: NSObject {
    
    
    @objc class func createModule() -> UIViewController {
        
        let view = CharactersListViewController()
        
        let presenter: CharactersListPresenterImpl = CharactersListPresenterImpl()
        
        let interactor = CharactersListInteractorImpl()
        
        let router: CharactersListRouterImpl =  CharactersListRouterImpl(mainRouter: view)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
}
