//
//  CharactersListInteractorImpl.swift
//  superBank
//
//  Created by Jaime Tejeiro on 10/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//
import Foundation
import Alamofire



class CharactersListInteractorImpl {
    
    // MARK: - Properties
    weak var presenter: CharactersListInteractorCallback?
    
    // MARK: - Repository
    
    // MARK: - Manager
    
    // MARK: - Var
    let relativePath = "characters"
    
    init () {
        
    }
}

extension CharactersListInteractorImpl: CharactersListInteractor {
    
    // MARK: - fetch CharactersListInteractorImpl
    func fetchCharactersList(parameters:[String:Any]){
        fetchCharactersListApiClient(parameters: parameters)
    }
    
}

extension CharactersListInteractorImpl {
    
   
    
    // MARK: - fetch CharactersListInteractorImpl ApiCliente
    func fetchCharactersListApiClient(parameters:[String:Any]) {
        
        BaseAPIClient().getAPIRequest(relativePath: self.relativePath, parameters: parameters).response{ (response) in
            debugPrint(response)
            
            switch response.result {
            case .success:
                print("Validation Successful")
                guard let data = response.data else {return}
                if let result = try? JSONDecoder().decode(BasesMarvelResponse.self, from: data){
                    let basePager:BasesPagerModel = result.data
                    self.presenter?.fetchedCharactersList(result: .success(basePager))
                }
            case let .failure(error):
                print(error)
                self.presenter?.fetchedCharactersList(result: .failure(error))
            }
        }
        
    }
    
    
    
    
    // MARK: - fetch CharactersListInteractorImpl DataManager
    
    
    
}
