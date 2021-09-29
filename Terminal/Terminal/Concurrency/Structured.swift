//
//  Structured_Concurrency.swift
//  Terminal
//
//  Created by Harry on 29/09/21.
//

import Foundation

enum DataError: Error {
    case invalid
    case urlInvalid
}

func fetchData(at index: Int) async throws {
    print("\(Thread.current)" + ": \(index)" + ": Before")
    
    let url = URL(string: "https://my-json-server.typicode.com/typicode/demo/posts")
    
    guard let url = url else {
        throw DataError.urlInvalid
    }
    
    /// Ignore compiling error here, Xcode 13 tool chain not support very well
    let (data, response) = try await URLSession.shared.data(from: url)
    
    print("\(Thread.current)" + ": \(index)" + ": After")
}
