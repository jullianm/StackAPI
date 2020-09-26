//
//  File.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

public struct Timeline: Codable {
    public let items: [TimelineItems]
    public let hasMore: Bool
    public let quotaMax, quotaRemaining: Int
}

public struct TimelineItems: Codable {
    public let postId, userId: Int?
    public let timelineType: TimelineType
    public let creationDate: Int
    public let title: String?
    public let detail: String?
    public let commentId, badgeId: Int?

}

public enum TimelineType: String, Codable {
    case acceptedAnAnswer = "accepted"
    case postedAnAnswer = "answered"
    case askedAQuestion = "asked"
    case earnedABadge = "badge"
    case postedAComment = "commented"
    case reviewedAnEdit = "reviewed"
    case editedAPost = "revision"
    case suggestedAnEdit = "suggested"
    
    public var title: String {
        switch self {
        case .acceptedAnAnswer:
            return "Accepted an answer"
        case .postedAnAnswer:
            return "Posted an answer"
        case .askedAQuestion:
            return "Asked a question"
        case .earnedABadge:
            return "Earned a badge"
        case .postedAComment:
            return "Posted a comment"
        case .reviewedAnEdit:
            return "Reviewed a suggested edit"
        case .editedAPost:
            return "Edited a post"
        case .suggestedAnEdit:
            return "Suggested an edit"
        }
    }
}

