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
    var apiClient: BaseAPIClient
    
    // MARK: - Manager
    
    // MARK: - Var
    let relativePath = "characters"
    
    init (apiClient:BaseAPIClient) {
        self.apiClient = apiClient
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
        
        apiClient.getAPIRequest(relativePath: self.relativePath, parameters: parameters).response{ (response) in
            debugPrint(response)
            
            switch response.result {
            case .success:
                print("Validation Successful")
                guard let data = response.data else {return}
                if let result = try? JSONDecoder().decode(BasesMarvelResponse.self, from: data){
                    let basePager:BasesPagerModel = result.data
                    self.presenter?.fetchedCharactersList(result: .success(basePager))
                }else {
                    let errorResponses = self.apiClient.hashAPIResponseError(data: data)
                    self.presenter?.fetchedTypeError(baseError: errorResponses)
                    
                }
            case let .failure(error):
                print(error)
                self.presenter?.fetchedCharactersList(result: .failure(error))
            }
        }
        
    }
    
    
    
    
    // MARK: - fetch CharactersListInteractorImpl DataManager
    
    
    
}
