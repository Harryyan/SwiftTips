//
//  ProductListViewModel.swift
//  Practice
//
//  Created by Harry Yan on 20/07/22.
//

import Foundation

final class ProductListViewModel: NSObject {
    private let usecase: ProductUseCaseProtocol
    
    @Published var items: [Product] = []
    
    init(usecase: ProductUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func loadData() {
        Task.detached(priority: .userInitiated) { [weak self] in
            do {
                let url = URL(string: "https://dummyjson.com/products")!
                self?.items = try await self?.usecase.loadData(from: url) ?? []
            } catch {
                // Pop up error window on main thread if needed
                print("\(error)")
            }
        }
    }
}
