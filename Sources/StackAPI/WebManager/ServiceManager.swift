//
//  ServiceManager.swift
//  
//
//  Created by Jullian Mercier on 2020-09-25.
//

import Foundation
import Combine

private typealias CacheID = String

protocol ServiceManager {
    func fetch<T: Decodable>(endpoint: Endpoint, model: T.Type) -> AnyPublisher<T, Error>
    func send<T:Decodable>(endpoint: Endpoint, model: T.Type) -> AnyPublisher<T, Error>
}

final class NetworkManager: ServiceManager {
    private var cache: [CacheID: Any] = [:]
    
    func fetch<T: Decodable>(endpoint: Endpoint, model: T.Type) -> AnyPublisher<T, Error> {
        if let cachedValue: AnyPublisher<T, Error> = resetOrFetchFromCache(endpoint: endpoint) {
            return cachedValue
        }
        
        guard let urlRequest = endpoint.urlRequest else {
            return Fail(error: Error.wrongURL).eraseToAnyPublisher()
        }
                
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError(Error.network)
            .map(\.data)
            .decode(type: model, decoder: decoder)
            .mapError(Error.decodingError)
            .print()
            .handleEvents(receiveOutput: { [weak self] model in
                if endpoint.method == .get {
                    self?.cache[endpoint.cacheID] = model
                }
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func send<T:Decodable>(endpoint: Endpoint, model: T.Type) -> AnyPublisher<T, Error> {
        guard let request = endpoint.urlRequest else {
            return Fail(error: Error.wrongURL).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError(Error.network)
            .map(\.data)
            .decode(type: model, decoder: decoder)
            .mapError(Error.decodingError)
            .print()
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

private extension NetworkManager {
    /// Sets the cache to empty or fetch a cached value if present.
    /// - Parameter endpoint: The endpoint that contains the action to execute (refresh cache or else).
    /// - Returns: An optional publsher with the cached value.
    func resetOrFetchFromCache<T>(endpoint: Endpoint) -> AnyPublisher<T, Error>? {
        switch endpoint.action {
        case .refresh:
            cache = [:]
            return nil
        case _:
            guard let value = cache[endpoint.cacheID] as? T else { return nil }
            return Just(value).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
}

