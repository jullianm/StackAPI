//
//  Inbox.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

public struct Inbox: Codable {
    public let items: [Message]
    public let hasMore: Bool
    public let quotaMax, quotaRemaining: Int
}

// MARK: - Item
public struct Message: Codable {
    public let questionId: Int
    public let isUnread: Bool
    public let creationDate: Int
    public let commentId, answerId: Int?
    public let itemType: MessageType
    public let link: String
    public let title: String
    public var body: String
}

public enum MessageType: String, Codable {
    case comment = "comment"
    case answer = "new_answer"
}
