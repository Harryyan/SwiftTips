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

func fetchData(_ index: Int) async throws {
    
    func sameThread() async {
        var a = 0
        
        for i in 1...1000 {
            a = 500 * i
        }
        
        print("\(Thread.current)"  + ": Test")
    }

    func differentThread(url: URL) async throws {
        let (data, response) =  try await URLSession.shared.data(from: url)
        
        print("\(Thread.current)"  + ": URLSession")
    }
    
    print("\(Thread.current)" + ": \(index)" + ": Before")
    
    let url = URL(string: "https://my-json-server.typicode.com/typicode/demo/posts")
    
    guard let url = url else {
        throw DataError.urlInvalid
    }
    
    
    await sameThread()
    try await differentThread(url: url)
    
    print("\(Thread.current)" + ": After")
}


/// async let await
func fetchDataAsyncLetTest() async throws {
    
}
