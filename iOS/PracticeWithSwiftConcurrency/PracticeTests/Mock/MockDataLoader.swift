//
//  MockDataLoader.swift
//  PracticeTests
//
//  Created by Harry Yan on 20/07/22.
//

import Foundation
@testable import Practice

struct MockDataLoader: Loadable {
    var items: [Product] = []
    
    func load(from url: URL) async throws -> [Product] {
        items
    }
}
