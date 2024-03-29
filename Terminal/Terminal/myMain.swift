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
