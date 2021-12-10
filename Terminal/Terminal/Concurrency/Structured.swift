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

func customAsync() async {
    var a = 0
    
    for i in 1...1000 {
        a = 500 * i
    }
    
    print("\(Thread.current)"  + ": Test")
}


func fetchData(_ index: Int) async throws {

    func differentThread(url: URL) async throws {
        let (data, response) =  try await URLSession.shared.data(from: url)
        
        print("\(Thread.current)"  + ": URLSession")
    }
    
    print("\(Thread.current)" + ": \(index)" + ": Before")
    
    let url = URL(string: "https://my-json-server.typicode.com/typicode/demo/posts")
    
    guard let url = url else {
        throw DataError.urlInvalid
    }
    
    
    await customAsync()
    try await differentThread(url: url)
    
    print("\(Thread.current)" + ": After")
}


/// async let await
func fetchDataAsyncLetTest() async throws {
    print("\(Thread.current)" + ": \(index)" + ": Before")
    
    let url = URL(string: "https://my-json-server.typicode.com/typicode/demo/posts")
    
    guard let url = url else {
        throw DataError.urlInvalid
    }
    
    async let test1 = try await customAsync()
    async let test2 = try await customAsync()
    async let test3 = try await customAsync()
    
    print("Test: " + "\(index)")
    
    let _ = try await [test1, test2, test3]
    
    print("\(Thread.current)" + ": \(index)" + ": After")
}

func fetchDataWithTaskGroup() {
    func sameThread(_ index: Int) async -> Int {
        var a = 0
        
        for i in 1...1000 {
            a = 500 * i
        }
        
        print("\(Thread.current)"  + ": Same Thread \(index)")
        
        return a
    }

    
    print("\(Thread.current)" + ": \(index)" + ": Before")
    
//    try? await withThrowingTaskGroup(of: Int.self, body: { group in
//        for i in 1...5 {
//            group.addTask {
//                /// sendable closure
//                /// can't capture mutable variables
//                return await sameThread(i)
//            }
//        }
//
//        /// won't wait for all group finish, will run when some of them finish
//        for try await value in group {
//            print(value)
//        }
//    })
}
