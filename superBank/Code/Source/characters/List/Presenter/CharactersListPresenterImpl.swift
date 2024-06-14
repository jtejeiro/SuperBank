//
//  CharactersListPresenterImpl.swift
//  superBank
//
//  Created by JT on 10/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import Foundation



class CharactersListPresenterImpl{
    
    
    // MARK: - Properties
    weak var view: CharactersListView?
    var interactor: CharactersListInteractor?
    var router: CharactersListRouter?
    
    // MARK: - Manager
    
    // MARK: - Var
    var charactersListVM : CharactersListViewModel?
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
        router?.goBack()
    }
    
    func didSelectRowAt(index:Int) {
        if  let charactersID = self.charactersListVM?.charactersList[index].id {
        router?.goCharactersDeteils(id: String(charactersID))
        }
    }
    
    func moreRefreshCharactersList() {
        if  offsetValue < self.charactersListVM?.pagerTotal ?? 0{
            charactersListVM?.moreCharactersList()
            refreshCharactersList()
        }
    }
    
    func onActionOrdenByName() {
        self.charactersListVM?.setOrdenByName()
        resfreshOrdenBy()
    }
    
    func onActionOrdenByModified() {
        self.charactersListVM?.setOrdenByModified()
        resfreshOrdenBy()
    }

    func actionSearchBarButtonClicked(text: String) {
        charactersListVM?.SetNameStartsWithValue(text: text)
        resfreshnameStartsWith()
        view?.resfreshTitleNavegationBar(title: text)
    }
    
}
// MARK: - CharactersListInteractorCallback methods
extension CharactersListPresenterImpl: CharactersListInteractorCallback {
    
    func fetchedCharactersList(result: Result<BasesPagerModel, Error>) {
        switch result {
        case .success(let data):
             let charactersListResponse:BasesPagerModel = data
                if firstCharactersList {
                    firstCharactersList = false
                    self.charactersListVM = CharactersListViewModel.mapperToCharactersListResponse(basesPager: charactersListResponse)
                }else{
                    self.charactersListVM?.charactersListMore(list: data.results)
                }
                view?.showCharacters(CharactersVM: self.charactersListVM!)
            
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
private extension CharactersListPresenterImpl {
    
    func refreshCharactersList(){
        let paramerters:[String:Any] = charactersListVM?.getListPagerParameters() ?? [pagerParamerterKey.limit.rawValue:limitValue,
            pagerParamerterKey.offset.rawValue:offsetValue]
        interactor?.fetchCharactersList(parameters: paramerters)
    }
    
    func resfreshOrdenBy(){
        firstCharactersList = true
        self.charactersListVM?.cleanCharactersList()
        self.charactersListVM?.cleanOffsetValue()
        self.charactersListVM?.cleanNameStartsWithValue()
        refreshCharactersList()
        view?.resfreshTitleNavegationBar(title:  self.charactersListVM?.nameStartsWithValue ?? "")
    }
    
    func resfreshnameStartsWith(){
        firstCharactersList = true
        self.charactersListVM?.cleanCharactersList()
        self.charactersListVM?.cleanOffsetValue()
        self.charactersListVM?.cleanOrderByValuee()
        refreshCharactersList()
    }
}
