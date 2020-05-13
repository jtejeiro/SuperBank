//
//  CharactersDetailsPresenterImpl.swift
//  superBank
//
//  Created by JT on 10/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import Foundation



class CharactersDetailsPresenterImpl {
    
    
    // MARK: - Properties
    weak var view: CharactersDetailsView?
    var interactor: CharactersDetailsInteractor?
    var router: CharactersDetailsRouter?
    
    // MARK: - Manager
   
    
    // MARK: - Var
    var CharactersDetailsVM : CharactersDetailsViewModel!
    
    // MARK: - Init
    init() {

    }
    
}

// MARK: - CharactersDetailsPresenter methods
extension CharactersDetailsPresenterImpl: CharactersDetailsPresenter {
    
    func viewDidLoad() {
        interactor?.fetchCharactersDetails()
    }
    
    func viewWillAppear() {
    }
    
    func viewDidAppear() {
        //
    }
    
    func userClickGoBack() {
        router?.goBack()
    }
    
    func onActionlink(title:String ,urlString: String) {
        router?.goShowWebViewController(title:title,urlString: urlString)
    }
    
}
// MARK: - CharactersDetailsInteractorCallback methods
extension CharactersDetailsPresenterImpl: CharactersDetailsInteractorCallback {
    
    func fetchedCharactersDetails(result: Result<[CharactersListResponse], Error>) {
        
        switch result {
        case .success(let data):
            let charactersListResponse = data
            self.CharactersDetailsVM = CharactersDetailsViewModel.mapperToCharactersDetailsResponse(charactersList: charactersListResponse)
            view?.showCharacters(CharactersVM: self.CharactersDetailsVM)
            
            
        case .failure(let error):
            print(error)
             view?.showAlertError(title: "Error", message: "check connection")
        }
    }
    
    func fetchedTypeError(baseError:BasesError){
           view?.showAlertError(title: baseError.code, message: baseError.message)
    }

}

// MARK: - Private methods
private extension CharactersDetailsPresenterImpl {
    
  
}
