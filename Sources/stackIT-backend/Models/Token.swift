//
//  Token.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

import Foundation

struct Token {
    let value: String
    let expiration: String
    
    var isNotEmpty: Bool {
        return value != "" && expiration != ""
    }
}

extension Token {
    static let empty = Token(value: .init(), expiration: .init())
}
