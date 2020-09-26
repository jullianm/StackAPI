//
//  File.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

public struct Comments: Codable {
    let items: [Comment]
    let hasMore: Bool
    let quotaRemaining: Int
}

public extension Comments {
    static let empty = Comments(items: [], hasMore: false, quotaRemaining: 0)
}

// MARK: - Item
public struct Comment: Codable {
    let owner: Owner
    let edited: Bool
    let score, creationDate, postId, commentId: Int
    let body: String
    let replyToUser: Owner?
}
