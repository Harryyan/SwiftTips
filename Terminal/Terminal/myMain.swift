//
//  main.swift
//  Terminal
//
//  Created by Harry Yan on 11/08/21.
//

import Foundation
import Combine

actor ProductsBuffer {
    var count = 0
    var size = 0
    
    init(size: Int) {
        self.size = size
    }
    
    func push(_ i: Int) {
        guard count < size else { return }
        
        count += 1
        print("Push: \(count)")
    }
    
    func pop() {
        guard count > 0 else { return }
        
        print("Pop: \(count)")
        count -= 1
    }
}

@propertyWrapper public struct ThreadSafe<T: Sendable> {
    private var _value: T
    private let lock = NSLock()
    private let queue: DispatchQueue

    public var wrappedValue: T {
        get {
            queue.sync { _value }
        }
        
        _modify {
            lock.lock()
            var tmp: T = _value

            defer {
                _value = tmp
                lock.unlock()
            }

            yield &tmp
        }
    }

    public init(wrappedValue: T, queue: DispatchQueue? = nil) {
        self._value = wrappedValue
        self.queue = queue ?? DispatchQueue(label: "com.test")
    }
}

struct Entity: Hashable {
    let id: Int
    let name: String
}

struct Container: Sendable {
    @ThreadSafe
    static var openChatRooms = Set<Entity>()
}

@main
struct Main {
    static func main() async {
        Task {
            await test1()
        }
        
        Task {
            for i in 0..<1000 {
                Container.openChatRooms.insert(Entity(id:i,name: "Room: \(i)"))
                print(i)
            }
        }
        
        
        try? await Task.sleep(nanoseconds: 30_000_000_000)
    }
    
    static func test1() async {
        Task {
            for i in 0..<1000 {
                Container.openChatRooms.insert(Entity(id:i,name: "Room: \(i)"))
                print(i)
            }
        }
    }
}

//class ProductsBuffer {
//    var count = 0
//
//    func push() {
//        count += 1
//        print("Push: \(count)")
//    }
//
//    func pop() {
//        count -= 1
//        print("Pop: \(count)")
//    }
//}
//
//@main
//struct Main {
//    static func main() {
//        let buffer = ProductsBuffer()
//        let dispatchQueue = DispatchQueue(label: "Serial Queue", attributes: .concurrent)
//
//        for _ in 0..<1000 {
//            dispatchQueue.async(flags:.barrier) {
//                buffer.push()
//            }
//        }
//
//        for _ in 0..<1000 {
//            dispatchQueue.async(flags:.barrier) {
//                buffer.pop()
//            }
//        }
//
//        Thread.sleep(forTimeInterval: 10)
//    }
//}
