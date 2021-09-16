//
//  main.swift
//  Terminal
//
//  Created by Harry Yan on 11/08/21.
//

import Foundation
import Combine

// @main
struct Main {
    static func main() async throws {
        let buffer = Buffer()
        
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
