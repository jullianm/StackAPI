//
//  Endpoint.swift
//  StackIT
//
//  Created by Jullian Mercier on 2020-07-25.
//

import Foundation

enum Endpoint {
    case questions(subendpoint: QuestionsEndpoint)
    case answers(subendpoint: AnswersEndpoint)
    case comments(subendpoint: CommentsEndpoint)
    case tags
    case user(token: String, key: String)
    case posts(token: String, key: String)
    case inbox(token: String, key: String)
    case timeline(token: String, key: String)
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/\(path)"
        components.queryItems = queryItems
        
        return components.url
    }
    
    var action: Action? {
        switch self {
        case .questions(let subendpoint):
            return subendpoint.action
        case _:
            return nil
        }
    }
    
    var urlRequest: URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/\(path)"
        components.queryItems = queryItems
        
        guard let url = url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = components.query?.data(using: .utf8)
        
        return request
    }
    
    var cacheID: String {
        switch self {
        case .questions(let subendpoint):
            switch subendpoint {
            case let .filters(tags, trending, status):
                return tags.joined(separator: ";") + "&" + trending + String(status?.pageCount ?? 0)
            case .ids(let ids):
                return ids
            case .keywords(let keywords, _):
                return keywords
            }
        case let .answers(subendpoint):
            switch subendpoint {
            case .questionId(let questionId):
                return subendpoint.path + questionId
            case .ids(let ids):
                return subendpoint.path + ids
            }
        case let .comments(subendpoint):
            switch subendpoint {
            case .answersIds(let ids),
                 .ids(let ids),
                 .questionsIds(let ids):
                return subendpoint.path + ids
            }
        default:
            return .init()
        }
    }
    
    private var host: String {
        return "api.stackexchange.com"
    }
        
    private var path: String {
        switch self {
        case .tags:
            return "2.2/tags"
        case .questions(let subendpoint):
            return subendpoint.path
        case .user:
            return "/2.2/me"
        case .posts:
            return "/2.2/me/posts"
        case .inbox:
            return "/2.2/me/inbox"
        case .comments(let subendpoint):
            return subendpoint.path
        case .answers(let subendpoint):
            return subendpoint.path
        case .timeline:
            return "/2.2/me/timeline"
        }
    }
    
    var headers: [String: String] {
        return .init()
    }
    
    var method: String {
        return "GET"
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .tags:
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "popular"),
                .init(name: "site", value: "stackoverflow")
            ]
        case let .user(token, key):
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "reputation"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "access_token", value: token),
                .init(name: "key", value: key)
            ]
        case .posts(let token, let key):
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "activity"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "access_token", value: token),
                .init(name: "key", value: key)
            ]
        case .inbox(token: let token, key: let key):
            return [
                .init(name: "site", value: "stackoverflow"),
                .init(name: "access_token", value: token),
                .init(name: "key", value: key),
                .init(name: "filter", value: "withbody")
            ]
        case .questions(let subendpoint):
            return subendpoint.queryItems
        case .answers(let subendpoint):
            return subendpoint.queryItems
        case .comments(let subendpoint):
            return subendpoint.queryItems
        case .timeline(token: let token, key: let key):
            return [
                .init(name: "site", value: "stackoverflow"),
                .init(name: "access_token", value: token),
                .init(name: "key", value: key)
            ]
        }
    }
    
    var mockData: Data {
        switch self {
        case .questions(let subendpoint):
            return subendpoint.mockData
        case .tags:
            return Bundle.main.data(from: "Tags.json")
        case .answers(let subendpoint):
            return subendpoint.mockData
        case .comments(let subendpoint):
            return subendpoint.mockData
        case .user:
            return Bundle.main.data(from: "User.json")
        case .posts:
            return Bundle.main.data(from: "Posts.json")
        case .inbox:
            return Bundle.main.data(from: "Inbox.json")
        case .timeline:
            return Bundle.main.data(from: "Timeline.json")
        }
    }
}

extension Bundle {
    func data(from file: String) -> Data {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        return data
    }
}

