//
//  CustomPublisher.swift
//  CustomPublisher
//
//  Created by Harry Yan on 7/09/21.
//

import Combine
import AppKit

struct EventPublisher: Publisher {
    // Declaring that our publisher doesn't emit any values,
    // and that it can never fail:
    typealias Output = Void
    typealias Failure = Never
    
    fileprivate var control: NSControl
    fileprivate var event: NSEvent
    
    // Combine will call this method on our publisher whenever
    // a new object started observing it. Within this method,
    // we'll need to create a subscription instance and
    // attach it to the new subscriber:
    func receive<S: Subscriber>(
        subscriber: S
    ) where S.Input == Output, S.Failure == Failure {
        // Creating our custom subscription instance:
        let subscription = EventSubscription<S>()
        
        subscription.target = subscriber
        
        // Attaching our subscription to the subscriber:
        subscriber.receive(subscription: subscription)
        
        // Connecting our subscription to the control that's
        // being observed:
        //           control.addTarget(subscription,
        //               action: #selector(subscription.trigger),
        //               for: event
        //           )
    }
}

class EventSubscription<Target: Subscriber>: Subscription
where Target.Input == Void {
    
    var target: Target?
    
    // This subscription doesn't respond to demand, since it'll
    // simply emit events according to its underlying UIControl
    // instance, but we still have to implement this method
    // in order to conform to the Subscription protocol:
    func request(_ demand: Subscribers.Demand) {}
    
    func cancel() {
        // When our subscription was cancelled, we'll release
        // the reference to our target to prevent any
        // additional events from being sent to it:
        target = nil
    }
    
    @objc func trigger() {
        // Whenever an event was triggered by the underlying
        // UIControl instance, we'll simply pass Void to our
        // target to emit that event:
        _ = target?.receive()
    }
}

/// Request usage in Subscription
struct Feed<Output>: Publisher {
    typealias Failure = Never
    
    var provider: () -> Output?
    
    func receive<S: Subscriber>(
        subscriber: S
    ) where S.Input == Output, S.Failure == Never {
        let subscription = Subscription(feed: self, target: subscriber)
        subscriber.receive(subscription: subscription)
    }
}


extension Feed {

    class Subscription<Target: Subscriber>: Combine.Subscription
    where Target.Input == Output {
        
        private let feed: Feed
        private var target: Target?
        
        init(feed: Feed, target: Target) {
            self.feed = feed
            self.target = target
        }
        
        func request(_ demand: Subscribers.Demand) {
            var demand = demand
            
            // We'll continue to emit new values as long as there's
            // demand, or until our provider closure returns nil
            // (at which point we'll send a completion event):
            while let target = target, demand > 0 {
                if let value = feed.provider() {
                    demand -= 1
                    demand += target.receive(value)
                } else {
                    target.receive(completion: .finished)
                    break
                }
            }
        }
        
        func cancel() {
            target = nil
        }
    }
}
