//
//  ConcurrentQueue.swift
//  Concurrency
//
//  Created by Harry Yan on 8/08/22.
//

import Foundation


func testConcurrenctQueue() {
    let concurrentQueue = DispatchQueue(label: "swiftlee.concurrent.queue", attributes: .concurrent)
    
    concurrentQueue.async {
        print("Task 1 started")
        
        Thread.sleep(forTimeInterval: 10)
        
        print("Task 1 finished")
    }
    
    print("done1")
    
    concurrentQueue.async {
        print("Task 2 started")
        // Do some work..
        print("Task 2 finished")
    }
    
    print("done2")
}


final class Messenger {
    private var messages: [String] = []
    private var queue = DispatchQueue(label: "messages.queue", attributes: .concurrent)

    var lastMessage: String? {
        return queue.sync {
            self.messages.last
        }
    }

    func postMessage(_ newMessage: String) {
        queue.async(flags: .barrier) {
            self.messages.append(newMessage)
        }
    }
}


