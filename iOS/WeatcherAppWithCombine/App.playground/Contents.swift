//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import Combine
import UIKit
import PlaygroundSupport

class ObservableTest: ObservableObject {
    @Published var test: String = ""
}

struct ContentView: View {
    @State private var username: String = ""

    
    var body: some View {
        VStack {
            if !username.isEmpty {
                Text("Temp: \(username)!")
            } else {
                Text("Waiting for input")
            }
            
            TextField("Username", text: $username)
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView().frame(width: 500, height: 600, alignment: .center))
