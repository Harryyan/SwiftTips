//
//  CombineMain.swift
//  CombineMain
//
//  Created by Harry Yan on 16/09/21.
//

import Combine

@main
struct CombineMain {
    static func main() async throws {
        let publisher = ["1", "2", "3", "4", "5"].publisher
        let subscriber = StringSubscriber()
        
        publisher.subscribe(subscriber)
    }
}
