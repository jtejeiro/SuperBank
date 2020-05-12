//
//  CharactersDetailsConfigurator.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//


import Foundation
import UIKit

@objc final class CharactersDetailsConfigurator: NSObject {
    
    @objc class func createModule(charactersID: String) -> UIViewController {
        
        let apiClient = BaseAPIClient()
        let view = CharactersDetailsViewController()
        
        let presenter: CharactersDetailsPresenterImpl = CharactersDetailsPresenterImpl()
        
        let interactor = CharactersDetailsInteractorImpl(charactersID: charactersID, apiClient: apiClient)
        
        let router: CharactersDetailsRouterImpl =  CharactersDetailsRouterImpl(mainRouter: view)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
}
