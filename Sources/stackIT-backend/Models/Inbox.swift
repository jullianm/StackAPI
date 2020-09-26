//
//  File.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

public struct Inbox: Codable {
    let items: [Message]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int
}

// MARK: - Item
public struct Message: Codable {
    let isUnread: Bool
    let creationDate: Int
    let commentId, answerId: Int?
    let itemType: MessageType
    let link: String
    let title: String
    var body: String
}

public enum MessageType: String, Codable {
    case comment = "comment"
    case answer = "new_answer"
}
