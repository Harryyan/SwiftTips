//
//  CombineOperators.swift
//  CombineOperators
//
//  Created by Harry Yan on 17/09/21.
//

import Combine
import Foundation

/// collect
/// map
/// flatmap
/// keypath
/// replace nil
/// replace emptys
/// scan
/// filter
/// removeDuplicates
/// compactmap
/// ignore output
/// first / last
/// drop first
/// drop while
/// drop unit output from
/// prefix

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


/// filter
func filterTest() {
    let numbers = (1...20).publisher
    
    numbers.filter { $0 % 2 == 0 }
    .sink {
        print($0)
    }
}

/// remove duplicates
/// only remove next duplicated words, not all of them
func removeDuplicates() {
    let words = "apple apple fruit apple mango watermelon apple".components(separatedBy: " ").publisher
    words
        .removeDuplicates()
        .sink {
            print($0)
        }
}

/// compact map
/// help to remove nil values
func compactmapTest() {
    let strings = ["a", "1.24", "b", "3.45", "5.66"].publisher.compactMap { Float($0) }.sink {
        print($0)
    }
}

/// ignore output
func ignoreOutputTest() {
    let numbers = (1...5000).publisher
    
    numbers.ignoreOutput().sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
}

/// First / last
func testFirstandLast() {
    let numbers = (1...9).publisher
    
    numbers.first(where: { $0 % 2 == 0})
        .sink {
            print($0)
        }
    
    numbers.last(where: { $0 % 2 == 0})
        .sink {
            print($0)
        }
}

/// Drop first
func dropFirstTest() {
    let numbers = (1...10).publisher
    
    numbers.dropFirst(5).sink {
        print($0)
    }
}

/// Drop while
/// drop elements until one meets the requirements
func droWhileTest() {
    let numbers = (1...10).publisher
    
    numbers.drop(while: {$0 % 3 != 0})
        .sink {
            print($0)
        }
}

/// drop until
func dropUntilTest() {
    let ready = PassthroughSubject<Void, Never>()
    let taps = PassthroughSubject<Int, Never>()
    
    let a = taps.drop(untilOutputFrom: ready)
        .sink {
            print($0)
        }
    
    (1...10).forEach { n in
        taps.send(n)
        
        if n == 3 {
            ready.send()
        }
    }
}


/// Prefix
func prefixTest() {
    let numbers = (1...10).publisher
    
    numbers.prefix(2).sink {
        print($0)
    }
    
    numbers.prefix(while: { $0 < 3 }).sink {
        print($0)
    }
}
