//
//  future.swift
//  future
//
//  Created by Harry Yan on 6/09/21.
//

import Foundation
import Combine

// will be executing when u call it
func createFuture() -> Future<Int, Never> {
    return Future { promise in
        print(Thread.current.description + ": func")
        promise(.success(3))
    }
}

// won't be executing when u call it
// will be executing when it has subscribers
func createDeferredFuture() -> AnyPublisher<Int, Never> {
  return Deferred {
    Future { promise in
      print("Closure executed")
      promise(.success(42))
    }
  }.eraseToAnyPublisher()
}



func test() {
    let future = createFuture()
    
    // add subscriber
    let sub1 = future.sink(receiveValue: { value in
      print("sub1: \(value)")
    }) // the Future executes because it has a subscriber

    let sub2 = future.sink(receiveValue: { value in
      print("sub2: \(value)")
    }) //  the Future executes again because it received another subscriber
}
