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
    
    var orderByValue:String = ""
    
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
        let charactersID = self.CharactersListVM.charactersList[index].id
        router?.goCharactersDeteils(id: String(charactersID))
    }
    
    func moreRefreshCharactersList() {
        if  offsetValue < self.CharactersListVM.pagerTotal {
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
       
        resfreshnOrdenBy()
    }
    
    func onActionOrdenByModified() {
        if orderByValue.isEmpty{
            orderByValue = OrdenByType.modifiedTop.rawValue
        }else if orderByValue == OrdenByType.modifiedTop.rawValue {
            orderByValue = OrdenByType.modifiedBottom.rawValue
        }else {
            orderByValue = OrdenByType.modifiedTop.rawValue
        }
        resfreshnOrdenBy()
    }
    
    func resfreshnOrdenBy(){
        firstCharactersList = true
        self.CharactersListVM.cleanCharactersList()
        offsetValue = 0
        refreshCharactersList()
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
            view?.showAlertError(title: "Error", message: "check connection")
        }
        
    }
    
    func getListPagerParameters() -> [String:Any] {
        var listParameter:[String:Any] = [pagerParamerterKey.limit.rawValue:limitValue,
        pagerParamerterKey.offset.rawValue:offsetValue]
        
        if !orderByValue.isEmpty {
            listParameter[pagerParamerterKey.orderBy.rawValue] = orderByValue
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
}
