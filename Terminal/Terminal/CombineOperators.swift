//
//  CombineOperators.swift
//  CombineOperators
//
//  Created by Harry Yan on 17/09/21.
//

import Combine

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
    
    let townSchool = School(name: "Town School", students: 23)
    school.value = townSchool
    
    townSchool.students.value += 1
    
    cancellable.cancel()
}
