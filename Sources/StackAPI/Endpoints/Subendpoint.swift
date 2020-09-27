//
//  Subendpoints.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

import Foundation


enum QuestionsEndpoint {
    case filters(tags: [String], trending: String, action: Action? = nil)
    case ids(_ ids: String)
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
        case .ids(let ids):
            return "2.2/questions/\(ids)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .filters(tags, trending, status):
            var items: [URLQueryItem] = [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: trending),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "filter", value: "withbody"),
                .init(name: "page", value: String(status?.pageCount ?? 0))
            ]
            if !tags.isEmpty {
                items.append(.init(name: "tagged", value: tags.joined(separator: ";")))
            }
            
            return items
        case let .keywords(keywords, _):
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "relevance"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "q", value: keywords)
            ]
        case .ids:
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "activity"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "filter", value: "withbody")
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
    case ids(_ ids: String)
    case questionId(_ questionId: String)
    
    var path: String {
        switch self {
        case let .questionId(questionId):
            return "2.2/questions/\(questionId)/answers"
        case .ids(let ids):
            return "2.2/answers/\(ids)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .questionId:
            return [
                .init(name: "order", value: "desc"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "filter", value: "withbody")
            ]
        case .ids:
            return [
                .init(name: "site", value: "stackoverflow"),
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "activity"),
                .init(name: "filter", value: "withbody")
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
    case ids(_ ids: String)
    case answersIds(_ answersId: String)
    case questionsIds(_ questionsId: String)
    
    var path: String {
        switch self {
        case .answersIds(let answersId):
            return "2.2/answers/\(answersId)/comments"
        case .ids(let ids):
            return "/2.2/comments/\(ids)"
        case .questionsIds(let questionsId):
            return "2.2/questions/\(questionsId)/comments"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .answersIds:
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "creation"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "filter", value: "withbody")
            ]
        case .ids:
            return [
                .init(name: "site", value: "stackoverflow"),
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "creation"),
                .init(name: "filter", value: "withbody")
            ]
        case .questionsIds:
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "creation"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "filter", value: "withbody")
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
