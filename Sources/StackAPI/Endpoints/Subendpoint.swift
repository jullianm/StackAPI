//
//  Subendpoints.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

import Foundation


enum QuestionsEndpoint {
    case filters(tags: [String],
                 trending: String,
                 action: Action? = nil,
                 credentials: StackCredentials? = nil)
    
    case ids(_ ids: String,
             action: Action? = nil,
             credentials: StackCredentials? = nil)
    
    case keywords(_ keywords: String,
                  action: Action? = nil)
    
    case vote(vote: Vote,
              questionId: String,
              credentials: StackCredentials)
    
    var method: Method {
        switch self {
        case .filters, .keywords, .ids:
            return .get
        case .vote:
            return .post
        }
    }
    
    var action: Action? {
        switch self {
        case .filters(_, _, let action, _):
            return action
        case .ids(_, let action, _):
            return action
        case .keywords(_, let action):
            return action
        case .vote:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .filters:
            return "2.2/questions"
        case .keywords:
            return "2.2/search/excerpts"
        case .ids(let ids, _, _):
            return "2.2/questions/\(ids)"
        case .vote(let vote, let questionId, _):
            var path = "2.2/questions/\(questionId)/\(vote.rawValue)"
            if vote.shouldCancelVote {
                path.append("/undo")
            }
            
            return path
        }
    }
    
    var cacheID: String {
        switch self {
        case let .filters(tags, trending, action, _):
            return path + tags.joined(separator: ";") + "&" + trending + String(action?.pageCount ?? 1)
        case let .ids(ids, action, _):
            return path + ids + String(action?.pageCount ?? 1)
        case let .keywords(keywords, action):
            return path + keywords + String(action?.pageCount ?? 1)
        case .vote:
            return .init()
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .filters(tags, trending, action, credentials):
            var items: [URLQueryItem] = [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: trending),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "page", value: String(action?.pageCount ?? 1))
            ]
            if !tags.isEmpty {
                items.append(.init(name: "tagged", value: tags.joined(separator: ";")))
            }
            
            if let credentials = credentials, !credentials.token.isEmpty {
                items.append(.init(name: "filter", value: "!3zl2.6HRQMHqUnHP9"))
                items.append(.init(name: "access_token", value: credentials.token))
            } else {
                items.append(.init(name: "filter", value: "!--1nZw8Pr5S*"))
            }

            return items
        case let .keywords(keywords, action):
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "relevance"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "q", value: keywords),
                .init(name: "page", value: String(action?.pageCount ?? 1))
            ]
        case .ids(_, let action, let credentials):
            var items: [URLQueryItem] = [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "activity"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "page", value: String(action?.pageCount ?? 1))
            ]
            
            if let credentials = credentials, !credentials.token.isEmpty {
                items.append(.init(name: "filter", value: "!3zl2.6HRQMHqUnHP9"))
                items.append(.init(name: "access_token", value: credentials.token))
            } else {
                items.append(.init(name: "filter", value: "!--1nZw8Pr5S*"))
            }
            
            return items
        case .vote(_, _, let credentials):
            return [
                URLQueryItem(name: "access_token", value: credentials.token),
                URLQueryItem(name: "key", value: credentials.key)
            ]
        }
    }
    
    var mockData: Data {
        switch self {
        case .filters, .ids:
            return Bundle.module.dataFromResource("Questions")
        case .keywords:
            return Bundle.module.dataFromResource("Search")
        case .vote:
            return Bundle.module.dataFromResource("VotedQuestion")
        }
    }
}

enum AnswersEndpoint {
    case ids(_ ids: String,
             action: Action? = nil,
             credentials: StackCredentials? = nil)
    
    case questionId(_ questionId: String,
                    action: Action? = nil,
                    credentials: StackCredentials? = nil)
    
    case vote(vote: Vote,
              answerId: String,
              credentials: StackCredentials)
    
    var method: Method {
        switch self {
        case .questionId, .ids:
            return .get
        case .vote:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case let .questionId(questionId, _, _):
            return "2.2/questions/\(questionId)/answers"
        case .ids(let ids, _, _):
            return "2.2/answers/\(ids)"
        case .vote(let vote, let answerId, _):
            var path = "2.2/answers/\(answerId)/\(vote.rawValue)"
            if vote.shouldCancelVote {
                path.append("/undo")
            }
            
            return path
        }
    }
    
    var cacheID: String {
        switch self {
        case let .questionId(questionId, action, _):
            return path + questionId + String(action?.pageCount ?? 1)
        case let .ids(ids, action, _):
            return path + ids + String(action?.pageCount ?? 1)
        case .vote:
            return .init()
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .questionId(_, let action, let credentials),
             .ids(_, let action, let credentials):
            var items: [URLQueryItem] = [
                .init(name: "order", value: "desc"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "page", value: String(action?.pageCount ?? 1))
            ]
            
            if let credentials = credentials, !credentials.token.isEmpty {
                items.append(.init(name: "access_token", value: credentials.token))
                items.append(.init(name: "filter", value: "!b6AubgRQF6zu4D"))
                
            } else {
                items.append(.init(name: "filter", value: "!--1nZxQ38Bk1"))
            }
            
            return items
            
        case .vote(_, _, let credentials):
            return [
                URLQueryItem(name: "access_token", value: credentials.token),
                URLQueryItem(name: "key", value: credentials.key)
            ]
        }
    }
    
    var mockData: Data {
        switch self {
        case .questionId, .ids:
            return Bundle.module.dataFromResource("Answers")
        case .vote:
            return Bundle.module.dataFromResource("VotedAnswer")
        }
    }
}

enum CommentsEndpoint {
    case ids(_ ids: String,
             action: Action? = nil,
             credentials: StackCredentials? = nil)
    
    case answersIds(_ answersId: String,
                    action: Action? = nil,
                    credentials: StackCredentials? = nil)
    
    case questionsIds(_ questionsId: String,
                      action: Action? = nil,
                      credentials: StackCredentials? = nil)
    
    case vote(vote: Vote,
              commentId: String,
              credentials: StackCredentials)
    
    var method: Method {
        switch self {
        case .questionsIds, .answersIds, .ids:
            return .get
        case .vote:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .answersIds(let answersId, _, _):
            return "2.2/answers/\(answersId)/comments"
        case .ids(let ids, _, _):
            return "/2.2/comments/\(ids)"
        case .questionsIds(let questionsId, _, _):
            return "2.2/questions/\(questionsId)/comments"
        case .vote(let vote, let commentId, _):
            var path = "2.2/comments/\(commentId)/upvote"
            if vote.shouldCancelVote {
                path.append("/undo")
            }
            
            return path
        }
    }
    
    var cacheID: String {
        switch self {
        case .answersIds(let ids, let action, _),
             .ids(let ids, let action, _),
             .questionsIds(let ids, let action, _):
            return path + ids + String(action?.pageCount ?? 1)
        case .vote:
            return .init()
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .answersIds(_, let action, let credentials),
             .questionsIds(_, let action, let credentials),
             .ids(_, let action, let credentials):
            var items: [URLQueryItem] = [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "creation"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "page", value: String(action?.pageCount ?? 1))
            ]
            
            if let credentials = credentials, !credentials.token.isEmpty {
                items.append(.init(name: "access_token", value: credentials.token))
                items.append(.init(name: "filter", value: "!--1nZxYynKnV"))
            } else {
                items.append(.init(name: "filter", value: "!9_bDE0E4s"))
            }
            
            return items
            
        case .vote(_, _, let credentials):
            return [
                URLQueryItem(name: "access_token", value: credentials.token),
                URLQueryItem(name: "key", value: credentials.key)
            ]
        }
    }
    
    var mockData: Data {        
        switch self {
        case .ids, .questionsIds, .answersIds:
            return Bundle.module.dataFromResource("Comments")
        case .vote:
            return Bundle.module.dataFromResource("VotedComment")
        }
    }
}
