//
//  CharactersListProtocols.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import Foundation


// MARK: - View Protocol
// Define CharactersListView
protocol CharactersListView: class {
    var presenter: CharactersListPresenter? { get set }
    func showCharacters(CharactersVM:CharactersListViewModel)
    func showAlertError(title:String,message:String)
    
}

// MARK: - Presenter


protocol CharactersListPresenter: class {
    
    var view: CharactersListView? { get set }
    var interactor: CharactersListInteractor? { get set }
    var router: CharactersListRouter? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    
    func userClickGoBack()
    func didSelectRowAt(index: Int)
    func moreRefreshCharactersList()
}


// MARK: - Interactor

protocol CharactersListInteractorCallback: class {
    func fetchedCharactersList(result: Result<BasesPagerModel, Error>)
    func fetchedTypeError(baseError:BasesError)
}

protocol CharactersListInteractor: class {
    
    var presenter: CharactersListInteractorCallback? { get set }
    func fetchCharactersList(parameters:[String:Any])
    
}

// MARK: - Router
protocol CharactersListRouter: class {
    func goBack()
    func goCharactersDeteils(id:String)
}
