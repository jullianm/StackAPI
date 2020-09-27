//
//  File 2.swift
//  
//
//  Created by Jullian Mercier on 2020-09-25.
//

import Foundation

public enum Error: Swift.Error {
    case wrongURL
    case corruptedData(Swift.Error?)
    case decodingError(Swift.Error?)
    case network(Swift.Error?)
}
