//
//  ActorTEST.swift
//  Terminal
//
//  Created by Harry on 15/03/22.
//

import Foundation

@_marker
public protocol sdfasd { }

protocol Popular: Actor {
    var popular: Bool { get }
}

actor Room: Popular {
    let roomNumber = "101"
    var visitorCount: Int = 0
    
    init() {}
    
    func visit() -> Int {
        visitorCount += 1
        return visitorCount
    }
}

extension Room {
    var popular: Bool {
        visitorCount > 0
    }
}
