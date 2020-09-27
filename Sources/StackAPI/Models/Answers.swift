//
//  File.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

import Foundation

public struct Answers: Codable {
    public let items: [Answer]
    public let hasMore: Bool
}

public struct Answer: Codable {
    public let owner: Owner
    public let isAccepted: Bool
    public let score, lastActivityDate: Int
    public let lastEditDate: Int?
    public let creationDate, answerId, questionId: Int
    public let body: String
}

public extension Answers {
    static let empty = Answers(items: [], hasMore: false)
}

public extension Answer {
    static let placeholder = Answer(owner: Owner.placeholder,
                                    isAccepted: false,
                                    score: 34000,
                                    lastActivityDate: 1590047664,
                                    lastEditDate: 1590047664,
                                    creationDate: 1590047664,
                                    answerId: 46,
                                    questionId: 45,
                                    body: bodyPlaceholder)
    
    private static let bodyPlaceholder: String = {
        return "<p>I prefer to make it without delegates and segues. It can be done with custom init or by setting optional values.</p>\n\n<p><strong>1. Custom init</strong></p>\n\n<pre><code>class ViewControllerA: UIViewController {\n  func openViewControllerB() {\n    let viewController = ViewControllerB(string: \"Blabla\", completionClosure: { success in\n      print(success)\n    })\n    navigationController?.pushViewController(animated: true)\n  }\n}\n\nclass ViewControllerB: UIViewController {\n  private let completionClosure: ((Bool) -&gt; Void)\n  init(string: String, completionClosure: ((Bool) -&gt; Void)) {\n    self.completionClosure = completionClosure\n    super.init(nibName: nil, bundle: nil)\n    title = string\n  }\n\n  func finishWork() {\n    completionClosure()\n  }\n}\n</code></pre>\n\n<p><strong>2. Optional vars</strong></p>\n\n<pre><code>class ViewControllerA: UIViewController {\n  func openViewControllerB() {\n    let viewController = ViewControllerB()\n    viewController.string = \"Blabla\"\n    viewController.completionClosure = { success in\n      print(success)\n    }\n    navigationController?.pushViewController(animated: true)\n  }\n}\n\nclass ViewControllerB: UIViewController {\n  var string: String? {\n    didSet {\n      title = string\n    }\n  }\n  var completionClosure: ((Bool) -&gt; Void)?\n\n  func finishWork() {\n    completionClosure?()\n  }\n}\n</code></pre>\n"
    }()
}
