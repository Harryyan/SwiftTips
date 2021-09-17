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
