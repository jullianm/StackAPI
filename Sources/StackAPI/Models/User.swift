//
//  File.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

// MARK: - Welcome
public struct User: Codable {
    public let items: [UserDetails]
}

public struct UserDetails: Codable {
    public let badgeCounts: BadgeCounts
    public let accountId: Int
    public let isEmployee: Bool
    public let lastModifiedDate, lastAccessDate, reputationChangeYear, reputationChangeQuarter: Int
    public let reputationChangeMonth, reputationChangeWeek, reputationChangeDay, reputation: Int
    public let creationDate: Int
    public let userType: String
    public let userId: Int
    public let location: String
    public let link, profileImage: String
    public let displayName: String
}

public struct BadgeCounts: Codable {
    public let bronze, silver, gold: Int
}

public extension User {
    static let empty = User(items: [])
}

