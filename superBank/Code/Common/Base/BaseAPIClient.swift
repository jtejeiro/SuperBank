//
//  BaseAPIClient.swift
//  superBank
//
//  Created by JT on 08/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//

import UIKit
import Alamofire
import CryptoSwift

protocol BaseAPIClientProtocol {
    
}

class BaseAPIClient:BaseAPIClientProtocol {
    
    private let KtimestampKey: String = "ts"
    private let KtimestampValue: String = "1234"
    private let KhashKey: String = "hash"
    private let Kapikey: String = "apikey"
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
        return (KtimestampValue + privateKeyValue + apiKeyValue).md5()
    }
    
    private var parametersConection:[ String : Any] {
        return [KtimestampKey:KtimestampValue,Kapikey:apiKeyValue,KhashKey:hashKeyValue]
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
            let errorResponses = BasesError(code: "Error", message: "Review data")
            print(messageLog ?? "error")
            return errorResponses
        }
    }
    
    
}
