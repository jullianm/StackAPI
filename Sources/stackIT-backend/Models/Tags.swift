//
//  File.swift
//  
//
//  Created by Jullian Mercier on 2020-09-26.
//

public struct Tags: Codable {
    let items: [TagName]
}

public struct TagName: Codable {
    let name: String
}
