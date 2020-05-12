//
//  BaseAPIClient.swift
//  superBank
//
//  Created by Jaime Tejeiro on 08/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import UIKit
import Alamofire
import CryptoSwift

protocol BaseAPIClientProtocol {
    
}

class BaseAPIClient:BaseAPIClientProtocol {
    
    private let timestampKey: String = "ts"
    private let timestampValue: String = "1234"
    private let hashKey: String = "hash"
    private let apikey: String = "apikey"
    private let apiKeyValue: String = NetworkConstants.shared.publicKey
    private let privateKeyValue: String = NetworkConstants.shared.privateKey
    
    
    private var baseURLAPI : URL {
           
        if let url = URL(string: NetworkConstants.shared.baseURLApi) {
               return url
           }else {
               return URL(string: "")!
           }
       }
    
    private var hashKeyValue : String {
        return (timestampValue + privateKeyValue + apiKeyValue).md5()
    }
    
    private var parametersConection:[ String : Any] {
        return [timestampKey:timestampValue,apikey:apiKeyValue,hashKey:hashKeyValue]
    }
    
    
    func getAPIRequest(relativePath: String , parameters:[ String : Any] ) -> DataRequest{
        let urlAbsolute = baseURLAPI.appendingPathComponent(relativePath)
        var parametersAbsolute:[ String : Any] = parametersConection
        
        if parameters.count > 0 {
            for key in parameters {
                parametersAbsolute[key.key] = key.value
            }
        }
        
        return AF.request(urlAbsolute, method: .get, parameters: parametersAbsolute , encoding: URLEncoding.default)
    }
    
    func hashAPIResponseError(data:Data) -> BasesError{
        if let errorResult = try? JSONDecoder().decode(BasesError.self, from: data){
            return errorResult
        }else {
            let messageLog = String(data: data, encoding: .utf8)
            let errorResponses = BasesError(code: "Error", message: "Revisar data")
            print(messageLog ?? "error")
            return errorResponses
        }
    }
    
    
}
