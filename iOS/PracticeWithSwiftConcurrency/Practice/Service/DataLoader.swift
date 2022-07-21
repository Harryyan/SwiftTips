//
//  DataLoader.swift
//  Practice
//
//  Created by Harry Yan on 18/07/22.
//

import Foundation

protocol Loadable {
    func load(from url: URL) async throws -> [Product]
}

struct DataLoader: Loadable {
    private let session: URLSession
    
    // Mock URLSession later using protocol
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func load(from url: URL) async throws -> [Product] {
        let (data, _) = try await session.data(from: url)
        let result = try JSONDecoder().decode(Products.self, from: data)
        
        return result.products
    }
}
