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
        let subscriber1 = StringSubscriber2()
        
        publisher.subscribe(subscriber)
        
        
        // Subjects - special publiser
        
        print("Subscriber 1")
        
        let subject = PassthroughSubject<String, MyError>()
        subject.subscribe(subscriber1)
        
        subject.send("test")
        subject.send("test2")
        
        // Operator tests
        dropUntilTest()
    }
}
