//
//  File 2.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

public struct Search: Codable {
    public let items: [SearchItem]
    public let hasMore: Bool
}

// MARK: - Item
public struct SearchItem: Codable {
    public let tags: [String]
    public let questionScore: Int
    public let isAccepted: Bool
    public let answerId: Int?
    public let isAnswered: Bool
    public let questionId: Int
    public let itemType: ItemType
    public let score, lastActivityDate, creationDate: Int
    public let body, excerpt, title: String
    public let hasAcceptedAnswer: Bool?
    public let answerCount: Int?
}

public enum ItemType: String, Codable {
    case answer = "answer"
    case question = "question"
}

