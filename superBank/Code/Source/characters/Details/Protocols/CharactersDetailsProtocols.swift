//
//  CharactersDetailsProtocols.swift
//  superBank
//
//  Created by JT on 10/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import Foundation


// MARK: - View Protocol
// Define CharactersDetailsView
protocol CharactersDetailsView: AnyObject {
    
    var presenter: CharactersDetailsPresenter? { get set }
    func showCharacters(CharactersVM:CharactersDetailsViewModel)
    func showAlertError(title:String,message:String)
    
}

// MARK: - Presenter


protocol CharactersDetailsPresenter: AnyObject {
    
    var view: CharactersDetailsView? { get set }
    var interactor: CharactersDetailsInteractor? { get set }
    var router: CharactersDetailsRouter? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func onActionlink(title:String , urlString:String)
    func userClickGoBack()
}


// MARK: - Interactor

protocol CharactersDetailsInteractorCallback: AnyObject {
     func fetchedCharactersDetails(result: Result<[CharactersListResponse], Error>)
     func fetchedTypeError(baseError:BasesError)
}

protocol CharactersDetailsInteractor: AnyObject {
    
    var presenter: CharactersDetailsInteractorCallback? { get set }
    func fetchCharactersDetails()
    
}

// MARK: - Router
protocol CharactersDetailsRouter: AnyObject {
    func goBack()
    func goOpenWeb(urlString:String)
    func goShowWebViewController(title:String, urlString:String)
}
