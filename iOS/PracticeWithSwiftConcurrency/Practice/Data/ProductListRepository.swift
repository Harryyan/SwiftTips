//
//  ProductListRepository.swift
//  Practice
//
//  Created by Harry Yan on 20/07/22.
//

import Foundation

protocol ProductListRepositoryProtocol {
    func loadData(from url: URL) async throws -> [Product]
}

struct ProductListRepository: ProductListRepositoryProtocol {
    private let dataLoader: Loadable
    
    init(loader: any Loadable) {
        dataLoader = loader
    }
    
    // MARK: - Protocols
    
    func loadData(from url: URL) async throws -> [Product] {
        return try await dataLoader.load(from: url)
    }
}
