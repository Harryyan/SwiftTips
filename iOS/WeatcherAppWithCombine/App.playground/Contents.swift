//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import Combine
import UIKit
import PlaygroundSupport

class WebService {
    
    func fetchWeather(city: String) -> AnyPublisher<Weather, Error> {
        
        guard let url = URL(string: URLs.weather(city: city)) else {
           
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .map { $0.main }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
}


struct ContentView: View {
    @State private var username: String = ""
    private var test = ""
    
    private var webservice: WebService {
        WebService.init()
    }
    
    var body: some View {
        VStack {
            if !username.isEmpty {
                Text("Temp: \(username)!")
            } else {
                Text("Waiting for input")
            }
            
            TextField("Username", text: $username)
        }
        .onAppear {
            print("sdfdsafsd")
            
            // not really work
            self.webservice.fetchWeather(city: "huston")
                .catch { _ in
                    Just(Weather.placeholder)
                }
                .map { weather in
                    if let temp = weather.temp {
                        return "\(temp) ℉"
                    } else {
                        return "Error getting weather!"
                    }
                }
                .assign(to: \.username, on: self)
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView().frame(width: 500, height: 600, alignment: .center))
