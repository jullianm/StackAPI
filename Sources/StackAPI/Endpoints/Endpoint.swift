//
//  Endpoint.swift
//  StackIT
//
//  Created by Jullian Mercier on 2020-07-25.
//

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
}

enum Endpoint {
    case questions(subendpoint: QuestionsEndpoint)
    case answers(subendpoint: AnswersEndpoint)
    case comments(subendpoint: CommentsEndpoint)
    case tags
    case user(credentials: StackCredentials)
    case posts(credentials: StackCredentials)
    case inbox(credentials: StackCredentials)
    case timeline(credentials: StackCredentials)
    
    var method: Method {
        switch self {
        case .answers(let subendpoint):
            return subendpoint.method
        case .questions(let subendpoint):
            return subendpoint.method
        case .comments(let subendpoint):
            return subendpoint.method
        case _:
            return .get
        }
    }
    
    private var url: URL? {
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
    
    var headers: [String: String] {
        switch self {
        case .answers(let subendpoint):
            return subendpoint.headers
        case .questions(let subendpoint):
            return subendpoint.headers
        case .comments(let subendpoint):
            return subendpoint.headers
        case _:
            return [:]
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
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if method == .post {
            request.httpBody = components.query?.data(using: .utf8)
        }
        
        return request
    }
    
    var cacheID: String {
        switch self {
        case let .questions(subendpoint):
            return subendpoint.cacheID
        case let .answers(subendpoint):
            return subendpoint.cacheID
        case let .comments(subendpoint):
            return subendpoint.cacheID
        default:
            return .init() /// no cache
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
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .tags:
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "popular"),
                .init(name: "site", value: "stackoverflow")
            ]
        case let .user(credentials):
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "reputation"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "access_token", value: credentials.token),
                .init(name: "key", value: credentials.key)
            ]
        case .posts(let credentials):
            return [
                .init(name: "order", value: "desc"),
                .init(name: "sort", value: "activity"),
                .init(name: "site", value: "stackoverflow"),
                .init(name: "access_token", value: credentials.token),
                .init(name: "key", value: credentials.key)
            ]
        case .inbox(let credentials):
            return [
                .init(name: "site", value: "stackoverflow"),
                .init(name: "access_token", value: credentials.token),
                .init(name: "key", value: credentials.key),
                .init(name: "filter", value: "withbody")
            ]
        case .questions(let subendpoint):
            return subendpoint.queryItems
        case .answers(let subendpoint):
            return subendpoint.queryItems
        case .comments(let subendpoint):
            return subendpoint.queryItems
        case .timeline(let credentials):
            return [
                .init(name: "site", value: "stackoverflow"),
                .init(name: "access_token", value: credentials.token),
                .init(name: "key", value: credentials.key)
            ]
        }
    }
    
    var mockData: Data {
        switch self {
        case .questions(let subendpoint):
            return subendpoint.mockData
        case .tags:
            return Bundle.module.dataFromResource("Tags")
        case .answers(let subendpoint):
            return subendpoint.mockData
        case .comments(let subendpoint):
            return subendpoint.mockData
        case .user:
            return Bundle.module.dataFromResource("User")
        case .posts:
            return Bundle.module.dataFromResource("Posts")
        case .inbox:
            return Bundle.module.dataFromResource("Inbox")
        case .timeline:
            return Bundle.module.dataFromResource("Timeline")
        }
    }
}

extension Bundle {
    func dataFromResource(_ resource: String) -> Data {
        guard let mockURL = url(forResource: resource, withExtension: "json"),
              let data = try? Data(contentsOf: mockURL) else {
            fatalError("Failed to load \(resource) from bundle.")
        }
        
        return data
    }
}

