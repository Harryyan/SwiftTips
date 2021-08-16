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
