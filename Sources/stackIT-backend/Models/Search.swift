//
//  File 2.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

public struct Search: Codable {
    let items: [SearchItem]
    let hasMore: Bool
}

// MARK: - Item
public struct SearchItem: Codable {
    let tags: [String]
    let questionScore: Int
    let isAccepted: Bool
    let answerId: Int?
    let isAnswered: Bool
    let questionId: Int
    let itemType: ItemType
    let score, lastActivityDate, creationDate: Int
    let body, excerpt, title: String
    let hasAcceptedAnswer: Bool?
    let answerCount: Int?
}

public enum ItemType: String, Codable {
    case answer = "answer"
    case question = "question"
}

