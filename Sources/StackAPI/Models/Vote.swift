//
//  Vote.swift
//  
//
//  Created by Jullian Mercier on 2020-10-11.
//

import Foundation

public enum Vote {
    case upvote(undo: Bool = false)
    case downvote(undo: Bool = false)
    
    var rawValue: String {
        switch self {
        case .upvote:
            return "upvote"
        case .downvote:
            return "downvote"
        }
    }
    
    var shouldCancelVote: Bool {
        switch self {
        case let .downvote(undo), let .upvote(undo):
            return undo
        }
    }
}
