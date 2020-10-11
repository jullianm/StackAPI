//
//  StackCredentials.swift
//  
//
//  Created by Jullian Mercier on 2020-10-11.
//

import Foundation

public struct StackCredentials: Decodable {
    public let clientId: String
    public let key: String
    public var token: String = .init()
}
