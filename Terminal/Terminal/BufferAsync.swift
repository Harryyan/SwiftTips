//
//  BufferAsync.swift
//  BufferAsync
//
//  Created by Harry Yan on 13/08/21.
//

import Foundation


actor Buffer {
    private(set) var values = [Int]()
    
    func add(_ element: Int) {
        let temp = element
        values.append(temp)
        print("add: \(temp)")
    }
    
    func remove() {
        let temp = values.popLast() ?? -1
        print("remove: \(temp)")
    }
}

@main
struct Main {
    static func main() async throws {
        await withTaskGroup(of: Bool.self) { group in
            // Producer
            for i in 0 ... 100 {
                group.addTask() {
                    await buffer.add(i)
                    return true
                }
                
                print("########")
                
                group.addTask() {
                    await buffer.remove()
                    return true
                }
                
                print("*********")
            }
        }
    }
}
