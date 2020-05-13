//
//  NetworkConstants.swift
//  superBank
//
//  Created by JT on 08/05/2020.
//  Copyright © 2020 JT. All rights reserved.
//
import UIKit
import Foundation

class NetworkConstants {
    
    // MARK: - Constant
    
    private let typeFileNetworkConstants = "plist"
    private let nameFileNetworkConstants = "Config"
    
    // MARK: - Shared Instance
    
    static let shared = NetworkConstants()
    
    
    // MARK: - Properties
    
    private var plistNetworkConstants : Dictionary<String, Any>?
    
    
    // MARK: - Init
    init() {
        if let path = Bundle.main.path(forResource: nameFileNetworkConstants, ofType: typeFileNetworkConstants) {
            plistNetworkConstants = NSDictionary(contentsOfFile: path) as? [String: AnyObject]
        }
    }
    
    var baseURL: String {
        guard let baseURL = plistNetworkConstants?["baseURL"] as? String else {
            return ""
        }
        return baseURL
    }
    
    var versionApi: String {
        guard let versionApi = plistNetworkConstants?["versionApi"] as? String else {
            return ""
        }
        return versionApi
    }
    
    var apikey: String {
        guard let apikey = plistNetworkConstants?["PublicKey"] as? String else {
            return ""
        }
        return apikey
    }
    
    var publicKey: String {
        guard let publicKey = plistNetworkConstants?["PublicKey"] as? String else {
            return ""
        }
        return publicKey
    }
    
    
    var privateKey: String {
        guard let privateKey = plistNetworkConstants?["PrivateKey"] as? String else {
            return ""
        }
        return privateKey
    }
    
    var routeApi: String {
        guard let routeApi = plistNetworkConstants?["RouterApi"] as? String else {
            return ""
        }
        return routeApi
    }
    
    var baseURLApi: String {
        return baseURL + "/" + versionApi + "/" + routeApi + "/"
    }
    
    
    
}
