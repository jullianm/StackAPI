//
//  File.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

import Foundation
import KeychainAccess

public class KeychainManager {
    private(set) static public var shared = KeychainManager()
    private let keychainNameKey = "com.croissants.stackit"
    private let keychainAccessTokenKey = "access_token"
    private let keychainTokenExpirationKey = "token_expiration"
    
    public func retrieveToken() -> String? {
        let keychain = Keychain(service: keychainNameKey)
        return keychain[keychainAccessTokenKey]
    }
    
    public func storeToken(_ token: Token) {
        let keychain = Keychain(service: keychainNameKey)
        keychain[keychainAccessTokenKey] = token.value
        keychain[keychainTokenExpirationKey] = token.expiration
    }
    
    public func removeToken() {
        let keychain = Keychain(service: keychainNameKey)
        keychain[keychainAccessTokenKey] = nil
        keychain[keychainTokenExpirationKey] = nil
    }
    
    public func isTokenNotExpired() -> Bool {
//        return keychain[keychainTokenExpirationKey]
        return true
    }
}
