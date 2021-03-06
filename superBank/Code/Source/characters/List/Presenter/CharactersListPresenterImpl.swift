//
//  CharactersListPresenterImpl.swift
//  superBank
//
//  Created by JT on 10/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import Foundation



class CharactersListPresenterImpl {
    
    
    // MARK: - Properties
    weak var view: CharactersListView?
    var interactor: CharactersListInteractor?
    var router: CharactersListRouter?
    
    // MARK: - Manager
    
    // MARK: - Var
    var charactersListVM : CharactersListViewModel!
    var firstCharactersList:Bool = true
    var offsetValue:Int = 0
    var limitValue:Int = 20
    
    var orderByValue:String = ""
    var nameStartsWithValue:String = ""
    
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
        router?.goBack()
    }
    
    func didSelectRowAt(index:Int) {
        let charactersID = self.charactersListVM.charactersList[index].id
        router?.goCharactersDeteils(id: String(charactersID))
    }
    
    func moreRefreshCharactersList() {
        if  offsetValue < self.charactersListVM.pagerTotal {
            offsetValue = offsetValue + limitValue
            refreshCharactersList()
        }
    }
    
    func onActionOrdenByName() {
        if orderByValue.isEmpty{
            orderByValue = OrdenByType.nameZA.rawValue
        }else if orderByValue == OrdenByType.nameZA.rawValue {
            orderByValue = OrdenByType.nameAZ.rawValue
        }else {
            orderByValue = OrdenByType.nameZA.rawValue
        }
       
        resfreshOrdenBy()
    }
    
    func onActionOrdenByModified() {
        if orderByValue.isEmpty{
            orderByValue = OrdenByType.modifiedTop.rawValue
        }else if orderByValue == OrdenByType.modifiedTop.rawValue {
            orderByValue = OrdenByType.modifiedBottom.rawValue
        }else {
            orderByValue = OrdenByType.modifiedTop.rawValue
        }
        resfreshOrdenBy()
    }

    func actionSearchBarButtonClicked(text: String) {
        nameStartsWithValue = text
        resfreshnameStartsWith()
        view?.resfreshTitleNavegationBar(title: text)
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
                self.charactersListVM = CharactersListViewModel.mapperToCharactersListResponse(basesPager: charactersListResponse)
            }else{
                self.charactersListVM.charactersListMore(list: data.results)
            }
           
            
            view?.showCharacters(CharactersVM: self.charactersListVM)
           
            
        case .failure(let error):
            print(error)
            view?.showAlertError(title: "Error", message: "check connection")
        }
        
    }
    
    func getListPagerParameters() -> [String:Any] {
        var listParameter:[String:Any] = [pagerParamerterKey.limit.rawValue:limitValue,
        pagerParamerterKey.offset.rawValue:offsetValue]
        
        if !orderByValue.isEmpty {
            listParameter[pagerParamerterKey.orderBy.rawValue] = orderByValue
        }
        
        if !nameStartsWithValue.isEmpty {
            listParameter[pagerParamerterKey.nameStartsWith.rawValue] = nameStartsWithValue
        }
        
        return listParameter
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
    
    func resfreshOrdenBy(){
        firstCharactersList = true
        self.charactersListVM.cleanCharactersList()
        offsetValue = 0
        nameStartsWithValue = ""
        refreshCharactersList()
        view?.resfreshTitleNavegationBar(title: nameStartsWithValue)
    }
    
    func resfreshnameStartsWith(){
        firstCharactersList = true
        self.charactersListVM.cleanCharactersList()
        offsetValue = 0
        orderByValue = ""
        refreshCharactersList()
    }
}
