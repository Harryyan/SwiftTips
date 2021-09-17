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
        
        // School Test
        let citySchool = School(name: "City School", students: 100)
        let school = CurrentValueSubject<School, Never>(citySchool)
        
        let cancellable = school.sink {
            print($0)
        }
        
        let townSchool = School(name: "Town School", students: 23)
        school.value = townSchool

        
        
    }
}
