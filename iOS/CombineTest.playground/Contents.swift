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
        .map { $0.data }
        .decode(type: [Post].self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    
    return dataPublisher
}


let cancellable = getPosts().sink(receiveCompletion: {_ in }, receiveValue: {
    print($0)
})
