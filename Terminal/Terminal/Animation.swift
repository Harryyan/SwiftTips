//
//  Animation.swift
//  Animation
//
//  Created by Harry Yan on 28/08/21.
//

import SwiftUI

@propertyWrapper
struct AnimatedState<Value> : DynamicProperty {
    @State private var value: Value
    
    let animation: Animation?

    init(
        value: Value,
        animation: Animation? = nil
    ) {
        _value = State<Value>(initialValue: value)
        self.animation = animation
    }

    public var wrappedValue: Value {
        get {
            value
        }
        nonmutating set {
            self.process(newValue)
        }
    }

    public var projectedValue: Binding<Value> {
        _value.projectedValue
    }

    private func process(_ value: Value) {
        withAnimation(animation) {
            self.value = value
        }
    }
}
