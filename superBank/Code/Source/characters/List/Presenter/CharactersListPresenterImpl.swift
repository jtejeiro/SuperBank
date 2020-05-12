//
//  CharactersListPresenterImpl.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import Foundation



class CharactersListPresenterImpl {
    
    
    // MARK: - Properties
    weak var view: CharactersListView?
    var interactor: CharactersListInteractor?
    var router: CharactersListRouter?
    
    // MARK: - Manager
    
    // MARK: - Var
    var CharactersListVM : CharactersListViewModel!
    var firstCharactersList:Bool = true
    var offsetValue:Int = 0
    var limitValue:Int = 20
    
    // MARK: - Init
    init() {
        
    }
    
}

// MARK: - CharactersListPresenter methods
extension CharactersListPresenterImpl: CharactersListPresenter {
    
    func viewDidLoad() {
        refreshCharactersList()
    }
    
    func viewWillAppear() {
    }
    
    func viewDidAppear() {
        //
    }
    
    func userClickGoBack() {
        //TODO Mirar porque no se lanza esta función
        router?.goBack()
    }
    
    func didSelectRowAt(index:Int) {
        let charactersID = self.CharactersListVM.charactersList[index].id
        router?.goCharactersDeteils(id: String(charactersID))
    }
    
    func moreRefreshCharactersList() {
        if  offsetValue < self.CharactersListVM.pagerTotal {
            offsetValue = offsetValue + limitValue
            refreshCharactersList()
        }
    }
}
// MARK: - CharactersListInteractorCallback methods
extension CharactersListPresenterImpl: CharactersListInteractorCallback {
    
    func fetchedCharactersList(result: Result<BasesPagerModel, Error>) {
        switch result {
        case .success(let data):
            let charactersListResponse = data
            
            if firstCharactersList {
                firstCharactersList = false
                self.CharactersListVM = CharactersListViewModel.mapperToCharactersListResponse(basesPager: charactersListResponse)
            }else{
                self.CharactersListVM.charactersListMore(list: data.results)
            }
           
            
            view?.showCharacters(CharactersVM: self.CharactersListVM)
           
            
        case .failure(let error):
            print(error)
            view?.showAlertError(title: "Error", message: "revisar conexión")
        }
        
    }
    
    func getListPagerParameters() -> [String:Any] {
        return [pagerParamerterKey.limit.rawValue:limitValue,
        pagerParamerterKey.offset.rawValue:offsetValue]
    }
    
    func fetchedTypeError(baseError:BasesError){
        view?.showAlertError(title: baseError.code, message: baseError.message)
    }
    

}

// MARK: - Private methods
private extension CharactersListPresenterImpl {
    
    func refreshCharactersList(){
        interactor?.fetchCharactersList(parameters: getListPagerParameters())
    }
}
