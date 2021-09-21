import Foundation

public struct URLs {
    
    public static func weather(city: String) -> String {
        return "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=7d2dd8c9c5578b741c7735ad3f0d39ea&units=imperial"
    }
    
    // celsius = metric
    
}
