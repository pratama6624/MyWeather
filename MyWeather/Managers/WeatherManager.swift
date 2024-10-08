//
//  WeatherManager.swift
//  MyWeather
//
//  Created by Pratama One on 15/08/24.
//

import Foundation
import CoreLocation

class WeatherManager: ObservableObject {
    // Hardcode because it is only accurate when using an original iphone
    // Change to 0.0 when using original iphone
    @Published var latitude: Double = -6.2146
    @Published var longitude: Double = 106.8451
    @Published var city: String = "Loading..."
    
    // Open Weather API KEY
    private let openWeatherApiKey : String = "3f791f28c2dbc76d12631dcfe118e1e5"
    
    // Visual Crossing API KEY
    private let visualCrossingApiKey: String = "M95HDNXPUE5K9R655SKLL3UC2"
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        
        // Sample Jakarta Selatan
        self.latitude = -6.2146
        self.longitude = 106.8451
        
        // Sample SMK N 1 Giritontro
//        self.latitude = -8.08117095
//        self.longitude = 110.86730087840223
        
        // URL Request Open Weather
        guard let _ = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(openWeatherApiKey)&units=metric") else { fatalError("Missing URL")}
        
        // URL Request Visual Crossing
        guard let urlVisualCrossing = URL(string: "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(self.latitude),\(self.longitude)?key=\(visualCrossingApiKey)") else { fatalError("Missing URL") }
        
        // Open Weather Online Dummy
        // https://api.openweathermap.org/data/2.5/weather?q=Tangerang+Selatan&appid=3f791f28c2dbc76d12631dcfe118e1e5&units=metric
        
        // Visual Crossing Online Dummy
        // https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/-6.2146,106.8451?key=M95HDNXPUE5K9R655SKLL3UC2
        
        let urlRequest = URLRequest(url: urlVisualCrossing)
        
        print(urlRequest)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        print(data)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
//        print(decodedData)
        
        return decodedData
    }
    
    func loadCityName(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        do {
            if let city = try await CLLocationCoordinate2D(latitude: latitude, longitude: longitude).getCityNameFromNominatim() {
                DispatchQueue.main.async {
                    self.city = city
                }
            } else {
                DispatchQueue.main.async {
                    self.city = "City not found"
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.city = "Error fetching city: \(error)"
            }
        }
    }
    
    func getMultipleWeather(multipleLocation: String) async throws -> ResponseMultipleWeather {
        guard let urlMultipleRequest = URL(string: "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timelinemulti?key=\(visualCrossingApiKey)&locations=\(multipleLocation)") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: urlMultipleRequest)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }
        
        let decodeData = try JSONDecoder().decode(ResponseMultipleWeather.self, from: data)
        
        print(decodeData)
        
        return decodeData
    }
}

// Open Weather Response Body
//struct ResponseBody: Decodable {
//    var coord: CoordinatesResponse
//    var weather: [WeatherResponse]
//    var main: MainResponse
//    var name: String
//    var wind: WindResponse
//    
//    struct CoordinatesResponse: Decodable {
//        var lon: Double
//        var lat: Double
//    }
//    
//    struct WeatherResponse: Decodable {
//        var id: Double
//        var main: String
//        var description: String
//        var icon: String
//    }
//    
//    struct MainResponse: Decodable {
//        var temp: Double
//        var feels_like: Double
//        var temp_min: Double
//        var temp_max: Double
//        var pressure: Double
//        var humidity: Double
//    }
//    
//    struct WindResponse: Decodable {
//        var speed: Double
//        var deg: Double
//    }
//}
//
//extension ResponseBody.MainResponse {
//    var feelsLike: Double { return feels_like }
//    var tempMin: Double { return temp_min }
//    var tempMax: Double { return temp_max }
//}


// Visual Crossing Response Body
struct ResponseBody: Decodable, CustomDebugStringConvertible {
    var latitude: Double
    var longitude: Double
    var timezone: String
    var currentConditions: CurrentConditions
    var address: String
    var description: String
    let days: [Day]
    
    // MARK: - CurrentConditions
    struct CurrentConditions: Decodable, CustomDebugStringConvertible {
        var temp: Double
        var feelslike: Double
        var humidity: Double
        var windspeed: Double
        var visibility: Double
        var conditions: String
        
        var debugDescription: String {
            """
            Current Conditions:
            - Temp: \(temp)°C
            - Feels Like: \(feelslike)°C
            - Humidity: \(humidity)%
            - Wind Speed: \(windspeed) m/s
            - Visibility: \(visibility) km
            - Conditions: \(conditions)
            """
        }
    }
    
    // MARK: - Day
    struct Day: Decodable, CustomDebugStringConvertible, Identifiable {
        var id: TimeInterval { datetimeEpoch }
        var datetime: String
        var datetimeEpoch: TimeInterval
        var tempmax: Double
        var tempmin: Double
        var temp: Double
        var feelslikemax: Double
        var feelslikemin: Double
        var feelslike: Double
        var humidity: Double
        var windspeed: Double
        var visibility: Double
        var conditions: String
        var hours: [Hour]
        
        var debugDescription: String {
            """
            Day (\(datetime)):
                - Temp Max: \(tempmax)°C
                - Temp Min: \(tempmin)°C
                - Temp: \(temp)°C
                - Feels Like Max: \(feelslikemax)°C
                - Feels Like Min: \(feelslikemin)°C
                - Feels Like: \(feelslike)°C
                - Humidity: \(humidity)%
                - Wind Speed: \(windspeed) m/s
                - Visibility: \(visibility) km
                - Conditions: \(conditions)
                - Hours:
              \(hours.map { $0.debugDescription }.joined(separator: "\n  "))
            """
        }
        
        // MARK: - Hour
        struct Hour: Decodable, CustomDebugStringConvertible, Identifiable {
            var id: TimeInterval { datetimeEpoch }
            var datetime: String
            var datetimeEpoch: TimeInterval
            var temp: Double
            var feelslike: Double
            var humidity: Double
            var windspeed: Double
            var visibility: Double
            var conditions: String
            var uvindex: Int
            
            var debugDescription: String {
                """
                    Hour (\(datetime)):
                        - Temp: \(temp)°C
                        - Feels Like: \(feelslike)°C
                        - Humidity: \(humidity)%
                        - Wind Speed: \(windspeed) m/s
                        - Visibility: \(visibility) km
                        - Conditions: \(conditions)
                        - UV Index: \(uvindex) UV
                """
            }
        }
    }
    
    // MARK: - ResponseBody Debug Description
    var debugDescription: String {
        """
        ResponseBody:
        - Latitude: \(latitude)
        - Longitude: \(longitude)
        - Timezone: \(timezone)
        - Address: \(address)
        - Description: \(description)
        - Current Conditions:
          \(currentConditions.debugDescription)
        - Days:
          \(days.map { $0.debugDescription }.joined(separator: "\n  "))
        """
    }
}

struct ResponseMultipleWeather: Decodable {
    var locations: [ResponseLocation]
    
    struct ResponseLocation: Decodable, CustomDebugStringConvertible {
        var latitude: Double
        var longitude: Double
        var timezone: String
        var address: String
        let days: [Day]
        
        // MARK: - Day
        struct Day: Decodable, CustomDebugStringConvertible, Identifiable {
            var id: TimeInterval { datetimeEpoch }
            var datetime: String
            var datetimeEpoch: TimeInterval
            var tempmax: Double
            var tempmin: Double
            var temp: Double
            var feelslikemax: Double
            var feelslikemin: Double
            var feelslike: Double
            var humidity: Double
            var windspeed: Double
            var visibility: Double
            var conditions: String
            
            var debugDescription: String {
                """
                Day (\(datetime)):
                    - Temp Max: \(tempmax)°C
                    - Temp Min: \(tempmin)°C
                    - Temp: \(temp)°C
                    - Feels Like Max: \(feelslikemax)°C
                    - Feels Like Min: \(feelslikemin)°C
                    - Feels Like: \(feelslike)°C
                    - Humidity: \(humidity)%
                    - Wind Speed: \(windspeed) m/s
                    - Visibility: \(visibility) km
                    - Conditions: \(conditions)
                """
            }
        }
        
        // MARK: - ResponseBody Debug Description
        var debugDescription: String {
            """
            ResponseBody:
            - Latitude: \(latitude)
            - Longitude: \(longitude)
            - Timezone: \(timezone)
            - Address: \(address)
            - Days:
              \(days.map { $0.debugDescription }.joined(separator: "\n  "))
            """
        }
    }
}

