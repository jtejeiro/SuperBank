//
//  CharactersDetailsInteractorImpl.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//
import Foundation


class CharactersDetailsInteractorImpl {
    
    // MARK: - Properties
    weak var presenter: CharactersDetailsInteractorCallback?
    
    // MARK: - Repository
    
    // MARK: - Manager
   
    
    // MARK: - Var
    let relativePath = "characters/"
    var charactersID:String?
    
    init (charactersID:String) {
        self.charactersID = charactersID
    }
}

extension CharactersDetailsInteractorImpl: CharactersDetailsInteractor {
    
    // MARK: - fetch CharactersDetailsInteractorImpl
    func fetchCharactersDetails(){
          fetchCharactersDetailsApiClient()
      }
    
    
    // MARK: - fetch CharactersDetailsInteractorImpl ApiCliente
    
    
    
    // MARK: - fetch CharactersDetailsInteractorImpl DataManager
    
    
    
}
extension CharactersDetailsInteractorImpl {
    
   
    
    // MARK: - fetch CharactersListInteractorImpl ApiCliente
    func fetchCharactersDetailsApiClient() {
        let absolutePath = self.relativePath + self.charactersID! 
        
        BaseAPIClient().getAPIRequest(relativePath: absolutePath , parameters: [:]).response{ (response) in
            debugPrint(response)
            
            switch response.result {
            case .success:
                
                guard let data = response.data else {return}
                if let result = try? JSONDecoder().decode(BasesMarvelResponse.self, from: data){
                    let characters:[CharactersListResponse] = result.data.results
                    self.presenter?.fetchedCharactersDetails(result: .success(characters))
                }
                
            case let .failure(error):
                print(error)
                self.presenter?.fetchedCharactersDetails(result: .failure(error))
            }
        }
    }
    
    
    
    
    // MARK: - fetch CharactersListInteractorImpl DataManager
    
    
    
}

