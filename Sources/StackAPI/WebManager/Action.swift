//
//  Action.swift
//  
//
//  Created by Jullian Mercier on 2020-09-25.
//

public enum Action: Equatable {
    case paging(count: Int = 1)
    case refresh
    
    public func updatePagingCount() -> Self {
        switch self {
        case let .paging(count):
            return .paging(count: count + 1)
        default:
            return self
        }
    }
    
    public var pageCount: Int {
        switch self {
        case .paging(let count):
            return count
        default :
            return 1
        }
    }
}
