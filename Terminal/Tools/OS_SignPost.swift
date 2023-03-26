//
//  OS_SignPost.swift
//  Terminal
//
//  Created by Harry Yan on 26/03/23.
//

import Foundation
import os.log

let log = OSLog(subsystem: "User's description", category: .pointsOfInterest)

extension OSLog {
    func event(name: StaticString = "Points", _ string: String) {
        os_signpost(.event, log: self, name: name, "%{public}@", string)
    }

    /// Manually begin an interval
    func begin(name: StaticString = "Intervals", _ string: String) -> OSSignpostID {
        let id = OSSignpostID(log: self)
        os_signpost(.begin, log: self, name: name, signpostID: id, "%{public}@", string)
        return id
    }

    /// Manually end an interval
    func end(name: StaticString = "Intervals", _ string: String, id: OSSignpostID) {
        os_signpost(.end, log: self, name: name, signpostID: id, "%{public}@", string)
    }

    func interval<T>(name: StaticString = "Intervals", _ string: String, block: () throws -> T) rethrows -> T {
        let id = OSSignpostID(log: self)

        os_signpost(.begin, log: self, name: name, signpostID: id, "%{public}@", string)
        defer { os_signpost(.end, log: self, name: name, signpostID: id, "%{public}@", string) }
        return try block()
    }
}
