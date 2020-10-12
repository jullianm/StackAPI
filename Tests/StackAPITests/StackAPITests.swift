import Combine
import XCTest
@testable import StackAPI

final class StackAPITests: XCTestCase {
    private var api: StackITAPI!
    private var subscription: AnyCancellable?
    
    override func setUp() {
        api = StackITAPI(enableMock: true)
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
    
    func testFetchUser() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchUser(credentials: loadCredentials())
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
    
    func testFetchInbox() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchInbox(credentials: loadCredentials())
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
    
    func testFetchPosts() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchPosts(credentials: loadCredentials())
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
    
    func testFetchTimelime() {
        let expectation = XCTestExpectation()
        
        subscription = api.fetchTimeline(credentials: loadCredentials())
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
    
    func testUpvoteQuestion() {
        let expectation = XCTestExpectation()
        
        subscription = api.voteQuestion(vote: .upvote, questionId: "47494", credentials: loadCredentials())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { model in
                XCTAssertTrue(model.upvoted == true)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testDownvoteQuestion() {
        let expectation = XCTestExpectation()
        
        subscription = api.voteQuestion(vote: .downvote, questionId: "47494", credentials: loadCredentials())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { model in
                XCTAssertTrue(model.downvoted == true)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testUpvoteAnswer() {
        let expectation = XCTestExpectation()
        
        subscription = api.voteAnswer(vote: .upvote, answerId: "47494", credentials: loadCredentials())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { model in
                XCTAssertTrue(model.upvoted == true)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testDownvoteAnswer() {
        let expectation = XCTestExpectation()
        
        subscription = api.voteAnswer(vote: .downvote, answerId: "47494", credentials: loadCredentials())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { model in
                XCTAssertTrue(model.upvoted == true)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testUpvoteComment() {
        let expectation = XCTestExpectation()
        
        subscription = api.voteComment(vote: .upvote, commentId: "47494", credentials: loadCredentials())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { model in
                XCTAssertTrue(model.upvoted == true)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.5)
    }
}

extension StackAPITests {
    private func loadCredentials() -> StackCredentials {
        let url = URL(fileURLWithPath: #file)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Sources/StackAPI/Mocks/Credentials.json")
        let data = try! Data(contentsOf: url)
        
        return try! JSONDecoder().decode(StackCredentials.self, from: data)
    }
}
