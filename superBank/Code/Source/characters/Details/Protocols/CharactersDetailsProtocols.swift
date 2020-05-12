//
//  CharactersDetailsProtocols.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import Foundation


// MARK: - View Protocol
// Define CharactersDetailsView
protocol CharactersDetailsView: class {
    
    var presenter: CharactersDetailsPresenter? { get set }
    func showCharacters(CharactersVM:CharactersDetailsViewModel)
    func showAlertError(title:String,message:String)
    
}

// MARK: - Presenter


protocol CharactersDetailsPresenter: class {
    
    var view: CharactersDetailsView? { get set }
    var interactor: CharactersDetailsInteractor? { get set }
    var router: CharactersDetailsRouter? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    
    func userClickGoBack()
}


// MARK: - Interactor

protocol CharactersDetailsInteractorCallback: class {
     func fetchedCharactersDetails(result: Result<[CharactersListResponse], Error>)
     func fetchedTypeError(baseError:BasesError)
}

protocol CharactersDetailsInteractor: class {
    
    var presenter: CharactersDetailsInteractorCallback? { get set }
    func fetchCharactersDetails()
    
}

// MARK: - Router
protocol CharactersDetailsRouter: class {

}
