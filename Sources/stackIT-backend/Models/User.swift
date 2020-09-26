//
//  File.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

// MARK: - Welcome
public struct User: Codable {
    let items: [UserDetails]
}

public struct UserDetails: Codable {
    let badgeCounts: BadgeCounts
    let accountId: Int
    let isEmployee: Bool
    let lastModifiedDate, lastAccessDate, reputationChangeYear, reputationChangeQuarter: Int
    let reputationChangeMonth, reputationChangeWeek, reputationChangeDay, reputation: Int
    let creationDate: Int
    let userType: String
    let userId: Int
    let location: String
    let link, profileImage: String
    let displayName: String
}

public struct BadgeCounts: Codable {
    let bronze, silver, gold: Int
}

public extension User {
    static let empty = User(items: [])
}

