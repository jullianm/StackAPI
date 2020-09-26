//
//  Token.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

import Foundation

public struct Token {
    let value: String
    let expiration: String
    
    var isNotEmpty: Bool {
        return value != "" && expiration != ""
    }
}

public extension Token {
    static let empty = Token(value: .init(), expiration: .init())
}
