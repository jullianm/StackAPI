//
//  File.swift
//  
//
//  Created by Jullian Mercier on 2020-09-25.
//

public enum Action: Equatable {
    case page(count: Int = 1)
    case refresh
    
    func updatePagingCount() -> Self {
        switch self {
        case let .page(count):
            return .page(count: count + 1)
        default:
            return self
        }
    }
    
    var pageCount: Int {
        switch self {
        case .page(let count):
            return count
        default :
            return 1
        }
    }
}
