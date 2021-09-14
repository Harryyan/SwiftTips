//
//  Client.swift
//  Client
//
//  Created by Harry Yan on 15/09/21.
//

import Foundation

func generatorTest() {
    let builder = ConcreteBuilder()
    let director = Director(builder: builder)
    let product = director.construct()
    
    print(product)
}
