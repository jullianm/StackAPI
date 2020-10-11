//
//  Comments.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

public struct Comments: Codable {
    public let items: [Comment]
    public let hasMore: Bool
    public let quotaRemaining: Int
}

// MARK: - Item
public struct Comment: Codable {
    public let owner: Owner
    public let edited: Bool
    public let score, creationDate, postId, commentId: Int
    public let body: String
    public let replyToUser: Owner?
    public let upvoted: Bool?
}

public extension Comments {
    static let empty = Comments(items: [], hasMore: false, quotaRemaining: 0)
}
