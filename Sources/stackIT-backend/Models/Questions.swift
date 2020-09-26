//
//  File.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

import Foundation

public struct Questions: Codable {
    let items: [Question]
    let hasMore: Bool
    let quotaRemaining: Int
}

public extension Questions {
    static let empty = Questions(items: [], hasMore: false, quotaRemaining: 0)
}

// MARK: - Item
public struct Question: Codable {
    public let tags: [String]
    public let owner: Owner
    public let isAnswered: Bool
    public let viewCount, answerCount, score, lastActivityDate: Int
    public let creationDate: Int
    public let lastEditDate: Int?
    public let questionId: Int
    public let link: String
    public let title: String
    public let body: String
    public let acceptedAnswerId, closedDate: Int?
    public let closedReason: String?
}

public struct Owner: Codable {
    public let reputation: Int?
    public let userId: Int?
    public let userType: String?
    public let profileImage: String?
    public let displayName: String?
    public let link: String?
    public let acceptRate: Int?
}

public extension Question {
    static let placeholder = Question(tags: ["swift", "android", "ios"],
                                      owner: Owner.placeholder,
                                      isAnswered: true,
                                      viewCount: 2000000,
                                      answerCount: 25,
                                      score: 3456,
                                      lastActivityDate: 1590047664,
                                      creationDate: 1590047664,
                                      lastEditDate: 1590047664,
                                      questionId: 3548,
                                      link: "",
                                      title: "How to handle SwiftUI navigation View?",
                                      body: "",
                                      acceptedAnswerId: nil,
                                      closedDate: 1590047664,
                                      closedReason: nil)
}

public extension Owner {
    static let placeholder = Owner(reputation: 75896,
                                   userId: nil,
                                   userType: nil,
                                   profileImage: "https://www.gravatar.com/avatar/43ac0b36d98aa42d34d93ecc582a469c?s=128&d=identicon&r=PG",
                                   displayName: "Placeholder",
                                   link: nil,
                                   acceptRate: nil)
}
