//
//  CharactersListProtocols.swift
//  superBank
//
//  Created by JT on 10/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import Foundation


// MARK: - View Protocol
// Define CharactersListView
protocol CharactersListView: AnyObject {
    var presenter: CharactersListPresenter? { get set }
    func showCharacters(CharactersVM:CharactersListViewModel)
    func showAlertError(title:String,message:String)
    func resfreshTitleNavegationBar(title:String)
    
}

// MARK: - Presenter


protocol CharactersListPresenter: AnyObject {
    
    var view: CharactersListView? { get set }
    var interactor: CharactersListInteractor? { get set }
    var router: CharactersListRouter? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    
    func userClickGoBack()
    func didSelectRowAt(index: Int)
    func moreRefreshCharactersList()
    func onActionOrdenByName()
    func onActionOrdenByModified()
    func actionSearchBarButtonClicked(text: String)
}


// MARK: - Interactor

protocol CharactersListInteractorCallback: AnyObject {
    func fetchedCharactersList(result: Result<BasesPagerModel, Error>)
    func fetchedTypeError(baseError:BasesError)
}

protocol CharactersListInteractor: AnyObject {
    
    var presenter: CharactersListInteractorCallback? { get set }
    func fetchCharactersList(parameters:[String:Any])
    
}

// MARK: - Router
protocol CharactersListRouter: AnyObject {
    func goBack()
    func goCharactersDeteils(id:String)
}
