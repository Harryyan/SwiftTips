//
//  Builder.swift
//  Builder
//
//  Created by Harry Yan on 14/09/21.
//

import Foundation

protocol Builder {
    func buildPartA()
    func buildPartB()
    func buildPartC()
    
    func result() -> String
}

class ConcreteBuilder: Builder {
    
    var a = ""
    var b = ""
    var c = ""
    
    var product = ""
    
    func buildPartA() {
        a = "a"
    }
    
    func buildPartB() {
        b = "b"
    }
    
    func buildPartC() {
        c = "c"
    }
    
    func result() -> String {
        return a + b + c
    }
}
