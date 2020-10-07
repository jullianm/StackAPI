//
//  Subendpoints.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

import Foundation


enum QuestionsEndpoint {
    case filters(tags: [String], trending: String, action: Action? = nil)
    case ids(_ ids: String, action: Action? = nil)
    case keywords(_ keywords: String, action: Action? = nil)
    
    var action: Action? {
        switch self {
        case .filters(_, _, let status):
            return status
        case _:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .filters:
            return "2.2/questions"
        case .keywords:
            return "2.2/search/excerpts"
        case .ids(let ids,_ ):
            return "2.2/questions/\(ids)"
        }
    }
    
    var cacheID: String {
        switch self {
        case let .filters(tags, trending, action):
            return path + tags.joined(separator: ";") + "&" + trending + String(action?.pageCount ?? 1)
        case let .ids(ids, action):
            return path + ids + String(action?.pageCount ?? 1)
        case let .keywords(keywords, action):
            return path + keywords + String(action?.pageCount ?? 1)
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .filters(tags, trending, status):
            var items: [URLQueryItem] = [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: trending),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "filter", value: "!--1nZw8Pr5S*"),
                .init(name: "page", value: String(status?.pageCount ?? 1))
            ]
            if !tags.isEmpty {
                items.append(.init(name: "tagged", value: tags.joined(separator: ";")))
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
        case .ids(_, let action):
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "activity"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "filter", value: "!--1nZw8Pr5S*"),
                .init(name: "page", value: String(action?.pageCount ?? 1))
            ]
        }
    }
    
    var mockData: Data {
        switch self {
        case .filters, .ids:
            return Bundle.main.data(from: "Questions.json")
        case .keywords:
            return Bundle.main.data(from: "Search.json")
        }
    }
}

enum AnswersEndpoint {
    case ids(_ ids: String, action: Action? = nil)
    case questionId(_ questionId: String, action: Action? = nil)
    
    var path: String {
        switch self {
        case let .questionId(questionId, _):
            return "2.2/questions/\(questionId)/answers"
        case .ids(let ids, _):
            return "2.2/answers/\(ids)"
        }
    }
    
    var cacheID: String {
        switch self {
        case let .questionId(questionId, action):
            return path + questionId + String(action?.pageCount ?? 1)
        case let .ids(ids, action):
            return path + ids + String(action?.pageCount ?? 1)
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .questionId(_, let action):
            return [
                .init(name: "order", value: "desc"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "filter", value: "!--1nZxQ38Bk1"),
                .init(name: "page", value: String(action?.pageCount ?? 1))
            ]
        case .ids(_, let action):
            return [
                .init(name: "site", value: "stackoverflow"),
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "activity"),
                .init(name: "filter", value: "!--1nZxQ38Bk1"),
                .init(name: "page", value: String(action?.pageCount ?? 1))
            ]
        }
    }
    
    var mockData: Data {
        switch self {
        case .questionId, .ids:
            return Bundle.main.data(from: "Answers.json")
        }
    }
}

enum CommentsEndpoint {
    case ids(_ ids: String, action: Action? = nil)
    case answersIds(_ answersId: String, action: Action? = nil)
    case questionsIds(_ questionsId: String, action: Action? = nil)
    
    var path: String {
        switch self {
        case .answersIds(let answersId, _):
            return "2.2/answers/\(answersId)/comments"
        case .ids(let ids, _):
            return "/2.2/comments/\(ids)"
        case .questionsIds(let questionsId, _):
            return "2.2/questions/\(questionsId)/comments"
        }
    }
    
    var cacheID: String {
        switch self {
        case .answersIds(let ids, let action),
             .ids(let ids, let action),
             .questionsIds(let ids, let action):
            return path + ids + String(action?.pageCount ?? 1)
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .answersIds(_, let action):
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "creation"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "filter", value: "withbody"),
                .init(name: "page", value: String(action?.pageCount ?? 1))
            ]
        case .ids(_, let action):
            return [
                .init(name: "site", value: "stackoverflow"),
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "creation"),
                .init(name: "filter", value: "withbody"),
                .init(name: "page", value: String(action?.pageCount ?? 1))
            ]
        case .questionsIds(_, let action):
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "creation"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "filter", value: "withbody"),
                .init(name: "page", value: String(action?.pageCount ?? 1))
            ]
        }
    }
    
    var mockData: Data {
        switch self {
        case .ids, .questionsIds, .answersIds:
            return Bundle.main.data(from: "Comments.json")
        }
    }
}
