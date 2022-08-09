import Foundation

// 顺序执行，无论async or sync
func testSerialQueue() {
    let serialQueue = DispatchQueue(label: "swiftlee.serial.queue")
    
    serialQueue.async {
        print("Task 1 started")
    
        Thread.sleep(forTimeInterval: 1)
        
        
        print("Task 1 finished")
    }
    
    print("done1")
    
    serialQueue.async {
        print("Task 2 started")
        // Do some work..
        print("Task 2 finished")
    }
    
    print("done")
}

// poor performance
class UserStorage {
    private var users = [Int: User]()
    private let queue = DispatchQueue(label: "UserStorage.sync")
    
    func store(_ user: User) {
        queue.async {
            self.users[user.id] = user
        }
    }
    
    func user(withID id: Int) -> User? {
        // should be async
        queue.sync {
            // notify caller
            self.users[id]
        }
    }
}

struct User {
    let id: Int
    let name: String
}


// actor way
actor UserStorage2 {
    private var users = [Int: User]()
    
    func store(_ user: User) {
        users[user.id] = user
    }
    
    func user(withID id:Int) -> User? {
        users[id]
    }
}
