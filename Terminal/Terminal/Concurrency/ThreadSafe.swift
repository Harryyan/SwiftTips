import Foundation

@propertyWrapper public struct ThreadSafeByQueue<T: Sendable>: Sendable {
    private var _value: T
    private let lock = NSLock()
//    private let queue: DispatchQueue

    public var wrappedValue: T {
        get {
            lock.withLock {
                _value
            }
        }
        
        _modify {
            lock.lock()
            var tmp: T = _value

            defer {
                _value = tmp
                lock.unlock()
            }

            yield &tmp
        }
    }

    public init(wrappedValue: T) {
        self._value = wrappedValue
//        self.queue = queue ?? DispatchQueue(label: "com.test.queue")
    }
}





struct Entity: Hashable {
    let id: Int
    let name: String
}

struct Container: Sendable {
    @ThreadSafeByQueue
    static var openChatRooms = Set<Entity>()
}

@main
struct Main {
    static func main() async {
        await withThrowingTaskGroup(of: Void.self, body: { group in
            group.addTask {
                await write()
            }
        })
        
        Task {
            await read()
        }
        
        try? await Task.sleep(nanoseconds: 30_000_000_000)
    }
    
    static func read() async {
        Task {
            for _ in 0..<1000 {
                print("Read")
            }
        }
    }
    
    static func write() async {
        Task {
            for i in 0..<1000 {
                Container.openChatRooms.insert(Entity(id: i,name: "Room: \(i)"))
                print("Write")
            }
        }
    }
}
