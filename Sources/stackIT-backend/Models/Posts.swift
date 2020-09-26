//
//  File.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

public struct Posts: Codable {
    public let items: [Post]
    public let hasMore: Bool
    public let quotaMax, quotaRemaining: Int
}

// MARK: - Item
public struct Post: Codable {
    public let owner: Owner
    public let score, lastActivityDate, creationDate: Int
    public let postType: String
    public let postId: Int
    public let contentLicense: String
    public let link: String
    public let lastEditDate: Int?
}

