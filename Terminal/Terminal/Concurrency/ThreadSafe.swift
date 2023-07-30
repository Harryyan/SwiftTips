import Foundation
import os

// MARK: - Semaphore
@propertyWrapper
struct AtomicSemaphore<Value: Sendable> {
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

@propertyWrapper
struct AtomicNSLock<T: Sendable>: Sendable {
    private var value: T
    private let lock = NSLock()
    
    public var wrappedValue: T {
        get {
            lock.withLock {
                value
            }
        }
        
        _modify {
            lock.lock()
            var tmp: T = value
            
            defer {
                value = tmp
                lock.unlock()
            }
            
            yield &tmp
        }
    }
    
    public init(wrappedValue value: T) {
        self.value = value
    }
}

// MARK: - UnfairLock

@propertyWrapper
struct AtomicUnfairLock<T: Sendable> {
    private var value: T
    private var lock = OSAllocatedUnfairLock()
    
    var wrappedValue: T {
        get { lock.withLock { value } }
        
        _modify {
            lock.lock()
            var tmp: T = value
            
            defer {
                value = tmp
                lock.unlock()
            }
            
            yield &tmp
        }
    }
    
    init(wrappedValue value: T) {
        self.value = value
    }
}

// MARK: - RecusiveLock

@propertyWrapper
struct AtomicRecusiveLock<T: Sendable> {
    private var value: T
    private var lock = NSRecursiveLock()
    
    var wrappedValue: T {
        get { lock.withLock { value } }
        
        _modify {
            lock.lock()
            var tmp: T = value
            
            defer {
                value = tmp
                lock.unlock()
            }
            
            yield &tmp
        }
    }
    
    init(wrappedValue value: T) {
        self.value = value
    }
}


// MARK: -

// MARK: - Dispatch Queue

@propertyWrapper
class AtomicWithDispatchQueue<T: Sendable> {
    private let _queue: DispatchQueue
    private var _value: T
    
    public var projectedValue: AtomicWithDispatchQueue<T> {
        return self
    }
    
    public var wrappedValue: T {
        get {
            _queue.sync {
                _value
            }
        }
    }
    
    public init(wrappedValue value: T, queue: DispatchQueue? = nil) {
        _value = value
        _queue = queue ?? DispatchQueue(label: "com.mega.test", attributes: .concurrent)
    }
    
    public func mutate(_ mutation: @escaping (inout T) -> Void) {
        _queue.async(flags: .barrier) {
            mutation(&self._value)
        }
    }
}


// MARK: - NSLock

@propertyWrapper
class AtomicWithNSLock<T: Sendable> {
    private var _value: T
    private let _lock = NSLock()
    
    public var wrappedValue: T {
        get {
            _lock.withLock {
                _value
            }
        }
    }
    
    public var projectedValue: AtomicWithNSLock<T> { self }
    
    public init(wrappedValue value: T) {
        self._value = value
    }
    
    public func mutate(_ mutation: (inout T) -> Void) {
        _lock.withLock {
            mutation(&self._value)
        }
    }
}

// MARK: - Semaphore

@propertyWrapper
class AtomicWithSemaphore<T: Sendable> {
    private var _value: T
    private var _semaphore = DispatchSemaphore(value: 1)
    
    public var wrappedValue: T {
        get {
            _semaphore.wait()
            let temp = _value
            _semaphore.signal()
            return temp
        }
    }
    
    public var projectedValue: AtomicWithSemaphore<T> {
        return self
    }
    
    public init(wrappedValue value: T) {
        self._value = value
    }
    
    public func mutate(_ mutation: (inout T) -> Void) {
        _semaphore.wait()
        mutation(&self._value)
        _semaphore.signal()
    }
}
