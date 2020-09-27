//
//  Token.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

import Foundation

public struct Token {
    public let value: String
    public let expiration: String
    
    public var isNotEmpty: Bool {
        return value != "" && expiration != ""
    }
}

public extension Token {
    static let empty = Token(value: .init(), expiration: .init())
}
