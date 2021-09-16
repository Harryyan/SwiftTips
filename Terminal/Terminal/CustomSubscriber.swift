//
//  CustomSubscriber.swift
//  CustomSubscriber
//
//  Created by Harry Yan on 16/09/21.
//

import Combine

/// Steps:
/// 1. subscriber subscribe pubisher
/// 2. publisher give subscription to subscriber
/// 3. subscriber request values
/// 4. publisher send values
/// 5. publisher send completion

class StringSubscriber: Subscriber {
    
    func receive(subscription: Subscription) {
        print("Received Subscription!")
        subscription.request(.unlimited)           // backpressure
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("Received Value: ", input)
        
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Received Completion!")
    }
    
    typealias Input = String
    typealias Failure = Never
}
