//
//  ProductListUseCase.swift
//  Practice
//
//  Created by Harry Yan on 20/07/22.
//

import Foundation

protocol ProductUseCaseProtocol {
    func loadData(from url: URL) async throws -> [Product]
}

struct ProductUseCase: ProductUseCaseProtocol {
    private let repository: ProductListRepositoryProtocol
    
    init(repository: ProductListRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Protocols
    
    func loadData(from url: URL) async throws -> [Product] {
        return try await repository.loadData(from: url)
    }
}
