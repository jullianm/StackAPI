import Combine
import XCTest
@testable import StackAPI

final class StackAPITests: XCTestCase {
    private var api: StackITAPI!
    private var subscription: AnyCancellable?
    
    override func setUp() {
        api = .init(enableMock: true)
    }
    
    override func tearDown() {
        api = nil
        subscription = nil
    }
    
    func testFetchTags() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchPopularTags()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchQuestionsWithFilters() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchQuestionsWithFilters(tags: [], trending: .activity, action: nil, credentials: nil)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchQuestionsByIds() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchQuestionsByIds("46403030", action: nil, credentials: nil)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchQuestionsByKeywords() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchQuestionsByKeywords(keywords: "swift", action: nil)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchAnswersByIds() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchAnswersByIds("4664", action: nil, credentials: nil)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchAnswersByQuestionId() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchAnswersByQuestionId("47484", action: nil, credentials: nil)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchCommentsByAnswersIds() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchCommentsByAnswersIds("4646", action: nil, credentials: nil)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func fetchFetchCommentsByIds() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchCommentsByIds("4646", action: nil, credentials: nil)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchCommentsByQuestionsIds() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchCommentsByQuestionsIds("4646", action: nil, credentials: nil)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchUser() throws {
        let expectation = XCTestExpectation()
        let credentials = try XCTUnwrap(loadModel(resourceName: "Credentials",
                                                  type: StackCredentials.self))
        
        subscription = api.fetchUser(credentials: credentials)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchInbox() throws {
        let expectation = XCTestExpectation()
        let credentials = try XCTUnwrap(loadModel(resourceName: "Credentials",
                                                  type: StackCredentials.self))
        
        subscription = api.fetchInbox(credentials: credentials)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchPosts() throws {
        let expectation = XCTestExpectation()
        let credentials = try XCTUnwrap(loadModel(resourceName: "Credentials",
                                                  type: StackCredentials.self))
        
        subscription = api.fetchPosts(credentials: credentials)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchTimelime() throws {
        let expectation = XCTestExpectation()
        let credentials = try XCTUnwrap(loadModel(resourceName: "Credentials",
                                                  type: StackCredentials.self))
        
        subscription = api.fetchTimeline(credentials: credentials)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testUpvoteQuestion() throws {
        let expectation = XCTestExpectation()
        let credentials = try XCTUnwrap(loadModel(resourceName: "Credentials",
                                                  type: StackCredentials.self))
        
        subscription = api.voteQuestion(vote: .upvote(), questionId: "47494", credentials: credentials)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { model in
                XCTAssertTrue(model.items[0].upvoted == true)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testDownvoteQuestion() throws {
        let expectation = XCTestExpectation()
        let credentials = try XCTUnwrap(loadModel(resourceName: "Credentials",
                                                  type: StackCredentials.self))
        
        subscription = api.voteQuestion(vote: .downvote(), questionId: "47494", credentials: credentials)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { model in
                XCTAssertTrue(model.items[0].downvoted == true)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testUpvoteAnswer() throws {
        let expectation = XCTestExpectation()
        let credentials = try XCTUnwrap(loadModel(resourceName: "Credentials",
                                                  type: StackCredentials.self))
        
        subscription = api.voteAnswer(vote: .upvote(), answerId: "47494", credentials: credentials)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { model in
                XCTAssertTrue(model.items[0].upvoted == true)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testDownvoteAnswer() throws {
        let expectation = XCTestExpectation()
        let credentials = try XCTUnwrap(loadModel(resourceName: "Credentials",
                                                  type: StackCredentials.self))
        
        subscription = api.voteAnswer(vote: .downvote(), answerId: "47494", credentials: credentials)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { model in
                XCTAssertTrue(model.items[0].upvoted == true)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testUpvoteComment() throws {
        let expectation = XCTestExpectation()
        let credentials = try XCTUnwrap(loadModel(resourceName: "Credentials",
                                                  type: StackCredentials.self))
        
        subscription = api.voteComment(vote: .upvote(), commentId: "47494", credentials: credentials)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { model in
                XCTAssertTrue(model.items[0].upvoted == true)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
}

private extension StackAPITests {
    private func loadModel<T: Decodable>(resourceName: String, type: T.Type) -> T? {
        let data = Bundle.module.dataFromResource(resourceName)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try? decoder.decode(T.self, from: data)
    }
}
