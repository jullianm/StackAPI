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
    
    public init(enableMock: Bool = false) {
        self.serviceManager = enableMock ? MockManager(): NetworkManager()
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
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Questions` and `Error`.
    func fetchQuestionsWithFilters(tags: [String],
                                   trending: Trending,
                                   action: Action?,
                                   credentials: StackCredentials?) -> AnyPublisher<Questions, Error> {
        let subendpoint: QuestionsEndpoint = .filters(tags: tags,
                                                      trending: trending.rawValue,
                                                      action: action,
                                                      credentials: credentials)
        return serviceManager.fetch(endpoint: .questions(subendpoint: subendpoint),
                                    model: Questions.self)
    }
    
    /// Retrieve questions using questions ids from `Stack Exchange` API.
    /// - parameter ids: A concatenated list of questions ids.
    /// - parameter action: An optional action to specify : `page` or `refresh`.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Questions` and `Error`.
    func fetchQuestionsByIds(_ ids: String,
                             action: Action?,
                             credentials: StackCredentials?) -> AnyPublisher<Questions, Error> {
        let subendpoint: QuestionsEndpoint = .ids(ids,
                                                  action: action,
                                                  credentials: credentials)
        return serviceManager.fetch(endpoint: .questions(subendpoint: subendpoint),
                                    model: Questions.self)
    }
    
    /// Retrieve questions using filters from `Stack Exchange` API.
    /// - parameter keywords: A list of keywords.
    /// - parameter action: An optional action to specify : `page` or `refresh`.
    /// - returns : A type-erased publisher of `Search` and `Error`.
    func fetchQuestionsByKeywords(keywords: String, action: Action?) -> AnyPublisher<Search, Error> {
        serviceManager.fetch(endpoint: .questions(subendpoint: .keywords(keywords, action: action)),
                             model: Search.self)
    }
}

// MARK: Answers API calls
public extension StackITAPI {
    /// Retrieve answers using answers ids from `Stack Exchange` API.
    /// - parameter ids: A concatenated list of answers ids.
    /// - parameter action: An optional action to specify : `page` or `refresh`.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Answers` and `Error`.
    func fetchAnswersByIds(_ ids: String,
                           action: Action?,
                           credentials: StackCredentials?) -> AnyPublisher<Answers, Error> {
        let subendpoint: AnswersEndpoint = .ids(ids,
                                                action: action,
                                                credentials: credentials)
        return serviceManager.fetch(endpoint: .answers(subendpoint: subendpoint),
                                    model: Answers.self)
    }
    
    /// Retrieve answers using answers ids from `Stack Exchange` API.
    /// - parameter questionId: The question id.
    /// - parameter action: An optional action to specify : `page` or `refresh`.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Answers` and `Error`.
    func fetchAnswersByQuestionId(_ questionId: String,
                                  action: Action?,
                                  credentials: StackCredentials?) -> AnyPublisher<Answers, Error> {
        let subendpoint: AnswersEndpoint = .questionId(questionId,
                                                       action: action,
                                                       credentials: credentials)
        return serviceManager.fetch(endpoint: .answers(subendpoint: subendpoint),
                                    model: Answers.self)
    }
}

// MARK: Comments API calls
public extension StackITAPI {
    /// Retrieve comments using answers ids from `Stack Exchange` API.
    /// - parameter answersId: A concatenated list of answers ids.
    /// - parameter action: An optional action to specify : `page` or `refresh`.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Comments` and `Error`.
    func fetchCommentsByAnswersIds(_ answersIds: String,
                                   action: Action?,
                                   credentials: StackCredentials?) -> AnyPublisher<Comments, Error> {
        let subendpoint: CommentsEndpoint = .answersIds(answersIds,
                                                        action: action,
                                                        credentials: credentials)
        return serviceManager.fetch(endpoint: .comments(subendpoint: subendpoint),
                                    model: Comments.self)
    }
    
    /// Retrieve comments using comments ids from `Stack Exchange` API.
    /// - parameter ids: A concatenated list of comments ids.
    /// - parameter action: An optional action to specify : `page` or `refresh`.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Comments` and `Error`.
    func fetchCommentsByIds(_ ids: String,
                            action: Action?,
                            credentials: StackCredentials?) -> AnyPublisher<Comments, Error> {
        let subendpoint: CommentsEndpoint = .ids(ids,
                                                 action: action,
                                                 credentials: credentials)
        return serviceManager.fetch(endpoint: .comments(subendpoint: subendpoint),
                                    model: Comments.self)
    }
    
    /// Retrieve comments using questions ids from `Stack Exchange` API.
    /// - parameter questionsIds: A concatenated list of questions
    /// - parameter action: An optional action to specify : `page` or `refresh`.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Comments` and `Error`.
    func fetchCommentsByQuestionsIds(_ questionsIds: String,
                                     action: Action?,
                                     credentials: StackCredentials?) -> AnyPublisher<Comments, Error> {
        let subendpoint: CommentsEndpoint = .questionsIds(questionsIds,
                                                          action: action,
                                                          credentials: credentials)
        return serviceManager.fetch(endpoint: .comments(subendpoint: subendpoint),
                                    model: Comments.self)
    }
}

// MARK: User API calls
public extension StackITAPI {
    /// Retrieve user messages from `Stack Exchange` API.
    ///
    /// Required a registered app on `Stack Exchange`.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Inbox` and `Error`.
    func fetchInbox(credentials: StackCredentials) -> AnyPublisher<Inbox, Error> {
        serviceManager.fetch(endpoint: .inbox(credentials: credentials),
                             model: Inbox.self)
    }
    
    /// Retrieve user activities from `Stack Exchange` API.
    ///
    /// Required a registered app on `Stack Exchange`.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Timeline` and `Error`.
    func fetchTimeline(credentials: StackCredentials) -> AnyPublisher<Timeline, Error> {
        serviceManager.fetch(endpoint: .timeline(credentials: credentials),
                             model: Timeline.self)
    }
    
    /// Retrieve user posts from `Stack Exchange` API.
    ///
    /// Required a registered app on `Stack Exchange`.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Posts` and `Error`.
    func fetchPosts(credentials: StackCredentials) -> AnyPublisher<Posts, Error> {
        serviceManager.fetch(endpoint: .posts(credentials: credentials),
                             model: Posts.self)
    }
    
    /// Retrieve user profile from `Stack Exchange` API.
    ///
    /// Required a registered app on `Stack Exchange`.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `User` and `Error`.
    func fetchUser(credentials: StackCredentials) -> AnyPublisher<User, Error> {
        serviceManager.fetch(endpoint: .user(credentials: credentials),
                             model: User.self)
    }
}

// MARK: Vote API calls
public extension StackITAPI {
    /// Send a vote for a specific question  to `Stack Exchange` API.
    ///
    /// Required a registered app on `Stack Exchange`.
    /// - parameter vote: An upvote or downvote.
    /// - parameter questionId: The question to vote for.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Question` and `Error`.
    func voteQuestion(vote: Vote,
                      questionId: String,
                      credentials: StackCredentials) -> AnyPublisher<Question, Error> {
        let subendpoint: QuestionsEndpoint = .vote(vote: vote,
                                                   questionId: questionId,
                                                   credentials: credentials)
        
        return serviceManager.fetch(endpoint: .questions(subendpoint: subendpoint),
                                    model: Question.self)
    }
    
    /// Send a vote for a specific answer  to `Stack Exchange` API.
    ///
    /// Required a registered app on `Stack Exchange`.
    /// - parameter vote: An upvote or downvote.
    /// - parameter answerId: The answer to vote for.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Answer` and `Error`.
    func voteAnswer(vote: Vote,
                    answerId: String,
                    credentials: StackCredentials) -> AnyPublisher<Answer, Error> {
        let subendpoint: AnswersEndpoint = .vote(vote: vote,
                                                 answerId: answerId,
                                                 credentials: credentials)
        
        return serviceManager.fetch(endpoint: .answers(subendpoint: subendpoint),
                                    model: Answer.self)
    }
    
    /// Send an upvote for a specific comment  to `Stack Exchange` API.
    ///
    ///  Required a registered app on `Stack Exchange`.
    ///
    ///  Downvote not available for comments.
    /// - parameter vote: Must be an upvote.
    /// - parameter commentId: The comment to upvote.
    /// - parameter credentials: The app credentials including the user access token.
    /// - returns : A type-erased publisher of `Comment` and `Error`.
    func voteComment(vote: Vote,
                     commentId: String,
                     credentials: StackCredentials) -> AnyPublisher<Comment, Error> {
        precondition(vote == .upvote, "Downvote not available.")
        
        let subendpoint: CommentsEndpoint = .vote(vote: vote,
                                                  commentId: commentId,
                                                  credentials: credentials)
        
        return serviceManager.fetch(endpoint: .comments(subendpoint: subendpoint),
                                    model: Comment.self)
    }
}
