//
//  StackITAPI.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

import Combine

/// Retrieve objects from the `Stack Exchange` API.
/// Initialize it with `ServiceManager` to get real data or `MockManager` to get mock data.
public class StackITAPI {
    let serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
}

// MARK: - Tags API call
public extension StackITAPI {
    /// Retrieve popular tags from `Stack Exchange` API.
    /// - returns : A type-erased publisher of `Tags` and `Error`.
    func fetchPopularTags() -> AnyPublisher<Tags, Error> {
        return serviceManager.fetch(endpoint: .tags, model: Tags.self)
    }
}

// MARK: Questions API calls
public extension StackITAPI {
    /// Retrieve questions using filters from `Stack Exchange` API.
    /// - parameter tags: A list of tags.
    /// - parameter trending: 3 possible options: `activity`, `hot`, `votes` .
    /// - parameter action: An optional action to specify : `page` or `refresh`.
    /// - returns : A type-erased publisher of `Questions` and `Error`.
    func fetchQuestionsWithFilters(tags: [String], trending: Trending, action: Action?) -> AnyPublisher<Questions, Error> {
        serviceManager.fetch(endpoint: .questions(subendpoint: .filters(tags: tags,
                                                                        trending: trending.rawValue,
                                                                        action: action)),
                             model: Questions.self)
    }
    
    /// Retrieve questions using questions ids from `Stack Exchange` API.
    /// - parameter ids: A concatenated list of questions ids.
    /// - returns : A type-erased publisher of `Questions` and `Error`.
    func fetchQuestionsByIds(_ ids: String) -> AnyPublisher<Questions, Error> {
        serviceManager.fetch(endpoint: .questions(subendpoint: .ids(ids)),
                             model: Questions.self)
    }
    
    /// Retrieve questions using filters from `Stack Exchange` API.
    /// - parameter keywords: A list of keywords.
    /// - returns : A type-erased publisher of `Questions` and `Error`.
    func fetchQuestionsByKeywords(keywords: String, action: Action?) -> AnyPublisher<Questions, Error> {
        serviceManager.fetch(endpoint: .questions(subendpoint: .keywords(keywords, action: action)),
                             model: Questions.self)
    }
}

// MARK: Answers API calls
public extension StackITAPI {
    /// Retrieve answers using answers ids from `Stack Exchange` API.
    /// - parameter ids: A concatenated list of answers ids.
    /// - returns : A type-erased publisher of `Answers` and `Error`.
    func fetchAnswersByIds(_ ids: String) -> AnyPublisher<Answers, Error> {
        serviceManager.fetch(endpoint: .answers(subendpoint: .ids(ids)),
                             model: Answers.self)
    }
    
    /// Retrieve answers using answers ids from `Stack Exchange` API.
    /// - parameter questionId: The question id.
    /// - returns : A type-erased publisher of `Answers` and `Error`.
    func fetchAnswersByQuestionId(_ questionId: String) -> AnyPublisher<Answers, Error> {
        serviceManager.fetch(endpoint: .answers(subendpoint: .questionId(questionId)),
                             model: Answers.self)
    }
}

// MARK: Comments API calls
public extension StackITAPI {
    /// Retrieve comments using answers ids from `Stack Exchange` API.
    /// - parameter answersId: A concatenated list of answers ids.
    /// - returns : A type-erased publisher of `Comments` and `Error`.
    func fetchCommentsByAnswersIds(_ answersIds: String) -> AnyPublisher<Comments, Error> {
        serviceManager.fetch(endpoint: .comments(subendpoint: .answersIds(answersIds)),
                             model: Comments.self)
    }
    
    /// Retrieve comments using comments ids from `Stack Exchange` API.
    /// - parameter ids: A concatenated list of comments ids.
    /// - returns : A type-erased publisher of `Comments` and `Error`.
    func fetchCommentsByIds(_ ids: String) -> AnyPublisher<Comments, Error> {
        serviceManager.fetch(endpoint: .comments(subendpoint: .ids(ids)),
                             model: Comments.self)
    }
    
    /// Retrieve comments using questions ids from `Stack Exchange` API.
    /// - parameter questionsIds: A concatenated list of questions ids.
    /// - returns : A type-erased publisher of `Comments` and `Error`.
    func fetchCommentsByQuestionsIds(_ questionsIds: String) -> AnyPublisher<Comments, Error> {
        serviceManager.fetch(endpoint: .comments(subendpoint: .questionsIds(questionsIds)),
                             model: Comments.self)
    }
}

// MARK: Account API calls
public extension StackITAPI {
    /// Retrieve user messages from `Stack Exchange` API.
    ///
    /// Required a registered app on `Stack Exchange`.
    /// - parameter token: The user token.
    /// - parameter key: The app key.
    /// - returns : A type-erased publisher of `Inbox` and `Error`.
    func fetchInbox(token: String, key: String) -> AnyPublisher<Inbox, Error> {
        serviceManager.fetch(endpoint: .inbox(token: token, key: key),
                             model: Inbox.self)
    }
    
    /// Retrieve user activities from `Stack Exchange` API.
    ///
    /// Required a registered app on `Stack Exchange`.
    /// - parameter token: The user token.
    /// - parameter key: The app key.
    /// - returns : A type-erased publisher of `Timeline` and `Error`.
    func fetchTimeline(token: String, key: String) -> AnyPublisher<Timeline, Error> {
        serviceManager.fetch(endpoint: .timeline(token: token, key: key),
                             model: Timeline.self)
    }
}
