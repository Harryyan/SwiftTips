import Foundation

public struct WeatherResponse: Decodable {
    public let main: Weather
}

public struct Weather: Decodable {
    public let temp: Double?
    public let humidity: Double?
    
    public static var placeholder: Weather {
        return Weather(temp: 44, humidity: 66)
    }
}
