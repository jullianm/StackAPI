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
    
    enum CodingKeys: String, CodingKey {
        case clientId
        case key
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        clientId = try container.decode(String.self, forKey: .clientId)
        key = try container.decode(String.self, forKey: .key)
    }
}
