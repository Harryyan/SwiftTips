//
//  future.swift
//  future
//
//  Created by Harry Yan on 6/09/21.
//

import Foundation
import Combine


func createFuture() -> Future<Int, Never> {
    return Future { promise in
        promise(.success(3))
    }
}
