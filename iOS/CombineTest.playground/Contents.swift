import UIKit
import Foundation
import Combine



struct Post: Codable {
    let title: String
    let body: String
}

/// Combine for Networking
/// URL Session
func getPosts() -> AnyPublisher<[Post], Error> {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        fatalError("Invalid URL!")
    }
    
    let dataPublisher = URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: [Post].self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    
    return dataPublisher
}

//
//let cancellable = getPosts().sink(receiveCompletion: {_ in }, receiveValue: {
//    print($0)
//})

///// Create timers
///// #1 - Runloop scheduler
//let runloop = RunLoop.main
//let cancelable = runloop.schedule(after: runloop.now, interval: .seconds(2), tolerance: .microseconds(100)) {
//    print("Timer Fired!")
//}
//
///// #2 - Timer
//let subscriber = Timer.publish(every: 1.0, on: .current, in: .common).autoconnect().sink {
//    print($0)
//}
//
//
///// #3
///// DispatchQueue
//
//let publisher = PassthroughSubject<Int, Never>()
//var count = 0
//let cancelable1 = DispatchQueue.main.schedule(after: DispatchQueue.main.now, interval: .seconds(1)) {
//    publisher.send(count)
//    count += 1
//}
//
//let cancelable2 = publisher.sink {
//    print($0)
//}
//

/// share results among publishers
guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
    fatalError("Invalid URL!")
}

var cancellables = Set<AnyCancellable>()
let subject = PassthroughSubject<Data, URLError>()
let request = URLSession.shared.dataTaskPublisher(for: url).map(\.data).print().multicast(subject: subject)
request.sink(receiveCompletion: { _ in }) {
    print("1:")
    print($0)
}
.store(in: &cancellables)

request.sink(receiveCompletion: { _ in }) {
    print("2:")
    print($0)
}
.store(in: &cancellables)

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    request.sink(receiveCompletion: { _ in }) {
        print("3:")
        print($0)
    }
    .store(in: &cancellables)
    
    request.connect().store(in: &cancellables)
}
