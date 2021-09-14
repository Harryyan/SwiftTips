//
//  Director.swift
//  Director
//
//  Created by Harry Yan on 14/09/21.
//

import Foundation

class Director {
    private let builder: Builder
    
    init(builder: Builder) {
        self.builder = builder
    }
    
    func construct() -> String {
        builder.buildPartA()
        builder.buildPartB()
        builder.buildPartC()
        
        return builder.result()
    }
}
