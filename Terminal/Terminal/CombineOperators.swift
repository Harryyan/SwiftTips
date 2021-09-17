//
//  CombineOperators.swift
//  CombineOperators
//
//  Created by Harry Yan on 17/09/21.
//

import Combine
import Foundation

struct School {
    let name: String
    let students: CurrentValueSubject<Int, Never>
    
    init(name: String, students: Int) {
        self.name = name
        self.students = CurrentValueSubject(students)
    }
}

/// Test flat map operator
func flatMapTest() {
    let citySchool = School(name: "City School", students: 100)
    let school = CurrentValueSubject<School, Never>(citySchool)
    
    let cancellable = school.flatMap {
        $0.students
    }
        .sink {
            print($0)
        }
    
    let townSchool = School(name: "Town School", students: 20)
    school.value = townSchool
    
    townSchool.students.value += 1
    
    cancellable.cancel()
}

/// collect
/// group elements and print
func collectTest() {
    let _ = [1,2,3,4].publisher.collect(2).sink {
        print($0)
    }
}

/// map
func mapTest() {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    let _ =  [1,2,3].publisher.map {
        formatter.string(from: NSNumber(value: $0)) ?? ""
    }.sink {
        print($0)
    }
}


/// map keypath
struct Point {
    let x: Int
    let y: Int
}

func keypathMapTest() {
    let publisher = PassthroughSubject<Point, Never>()
    
    let _ = publisher.map(\.x, \.y).sink {
        print("x is \($0), y is \($1)")
    }
}

/// replace nil
func replaceNilTest() {
    let _ =  [1,2,3,nil].publisher.replaceNil(with: 5)
        .map { $0! }
        .sink {
            print($0)
        }
}

/// replace empty
func replaceEmptyTest() {
    // init purpose
    let empty = Empty<Int, Never>()
    let _ = empty.replaceEmpty(with: 5).sink(receiveCompletion: { print($0)}, receiveValue: { print($0) } )
}

/// Scan
func scanTest() {
    let publisher = (1...10).publisher
    
    publisher.scan([]) { results, value in
        results + [value]
    }
    .sink {
        print($0)
    }
}
