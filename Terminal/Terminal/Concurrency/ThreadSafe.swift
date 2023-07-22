import Foundation
import os

// MARK: - Semaphore
@propertyWrapper
struct AtomicSemaphore<Value> {
    private var value: Value
    private var semaphore = DispatchSemaphore(value: 1)

    var wrappedValue: Value {
        get {
            semaphore.wait()
            let temp = value
            semaphore.signal()
            return temp
        }

        _modify {
            semaphore.wait()
            var tmp: Value = value
            
            defer {
                value = tmp
                semaphore.signal()
            }
            
            yield &tmp
        }
    }

    init(wrappedValue value: Value) {
        self.value = value
    }
}

// MARK: - DispatchQueue

@propertyWrapper
class AtomicDispatchQueue<Value: Sendable> {
    private var value: Value
    private let queue = DispatchQueue(label: "com.test.readerwriter", attributes: .concurrent)

    var wrappedValue: Value {
        get { queue.sync { value } }
        set { queue.async(flags: .barrier) { self.value = newValue } }
    }

    init(wrappedValue value: Value) {
        self.value = value
    }
}

// MARK: - NSLock

@propertyWrapper public struct AtomicNSLock<T: Sendable>: Sendable {
    private var _value: T
    private let lock = NSLock()
    
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
    }
}

// MARK: - UnfairLock

@propertyWrapper
final class AtomicUnfairLock<T> {
    private var _value: T
    private var lock = OSAllocatedUnfairLock()

    var wrappedValue: T {
        get { lock.withLock { _value } }
        
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

    init(wrappedValue value: T) {
        _value = value
    }
}

// MARK: - RecusiveLock

@propertyWrapper
final class AtomicRecusiveLock<T> {
    private var _value: T
    private var lock = NSRecursiveLock()

    var wrappedValue: T {
        get { lock.withLock { _value } }
        
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

    init(wrappedValue value: T) {
        _value = value
    }
}
