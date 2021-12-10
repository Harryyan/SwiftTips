//
//  CombineMain.swift
//  CombineMain
//
//  Created by Harry Yan on 16/09/21.
//

import Combine
import Foundation

class Pokemon: CustomDebugStringConvertible {
  let name: String
  init(name: String) {
    self.name = name
  }
  var debugDescription: String { return "<Pokemon \(name)>" }
  deinit { print("\(self) escaped!") }
}

func delay(closure: @escaping ()->()) {
    DispatchQueue.main.async {
        print("🕑")
        closure()
    }
}

final class Bar: ObservableObject {
  @Published var input: String = ""
  @Published var output: String = ""

  private var subscription: AnyCancellable?

  init() {
    subscription = $input
        .filter { $0.count > 0 }
        .map { "\($0) World!" }
        .assign(to: \.output, on: self)
  }

  deinit {
    subscription?.cancel()
    print("\(self): \(#function)")
  }
}

final class Bar1: ObservableObject {
    var input: String = "" {
        didSet {
            Just(input)
                .filter { $0.count > 0 }
                .map { "\($0) World!" }
                .assign(to: \.output, on: self)
                .store(in: &subscriptions)
        }
    }
    @Published var output: String = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    deinit {
        print("\(self): \(#function)")
    }
}



@main
struct CombineMain {
    static func main() {
//        let publisher = ["1", "2", "3", "4", "5"].publisher
//        let subscriber = StringSubscriber()
//        let subscriber1 = StringSubscriber2()
//
//        publisher.subscribe(subscriber)
//
//        // Subjects - special publiser
//
//        print("Subscriber 1")
//
//        let subject = PassthroughSubject<String, MyError>()
//        subject.subscribe(subscriber1)
//        subject.send("test")
//        subject.send("test2")
//
//        // Operator tests
//        reduceTest()
        
//        let pokemon = Pokemon(name: "Mewtwo")
//          print("before closure: \(pokemon)")
//        delay {
//            print("inside closure: \(pokemon)")
//          }
//
//          print("bye")
        
        // Ussage
        var bar: Bar? = Bar()
        let foo = bar?.$output.sink { print($0) }
        bar?.input = "Hello"
        bar = nil
    }
}
