//
//  CitySearchViewModel.swift
//  MyWeather
//
//  Created by Pratama One on 24/08/24.
//

import Foundation
import SwiftUI
import Combine

class CitySearchViewModel: ObservableObject {
    var weatherManager = WeatherManager()
    
    @Published var query: String = "Find city by name"
    private var cancellables = Set<AnyCancellable>()
    private var locationIQApiKey: String = "pk.dbe30b0178fa9e2c3d68e1e4c8269ab4"
    private let visualCrossingApiKey: String = "M95HDNXPUE5K9R655SKLL3UC2"
    
    private var multipleWeatherLocation: String = ""
    @Published var results: [RealTimeSearchResponseLocation] = []
    @Published var weatherResults: [RealTimeWeatherResponseMultiple] = []
    @Published var multipleLocation: [String] = []
    @Published var multipleLocationCitiesNames: [String] = []
    
    init() {
        $query
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] (query) in
                self?.searchForCity()
            }
            .store(in: &cancellables)
    }
    
    func searchForCity() {
        guard query.count >= 3, query != "Find city by name" else {
            results = []
            return
        }
        
        let urlString = "https://api.locationiq.com/v1/autocomplete?key=\(locationIQApiKey)&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&limit=5&dedupe=1"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Request failed with error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                do {
                    let decoder = JSONDecoder()
                    let cities = try decoder.decode([RealTimeSearchResponseLocation].self, from: data)
                    DispatchQueue.main.async {
                        self?.results = cities
                        self?.multipleLocationCitiesNames = cities.map { $0.detailAddress }
                        self?.multipleLocation = cities.map { $0.latAndLon }
                        self?.multipleWeatherLocation = self?.multipleLocation.joined(separator: "%7C") ?? ""
                        
                        if let _ = self?.multipleWeatherLocation {
                            self?.getMultipleWeather()
                        }
                    }
                } catch {
                    print("Failed to decode JSON with error: \(error)")
                }
            })
            .store(in: &cancellables)
        
        print(results)
    }
    
    func searchAndFetchWeatherForCity() {
        guard query.count >= 3, query != "Find city by name" else {
            results = []
            return
        }
        
        let locationUrlString = "https://api.locationiq.com/v1/autocomplete?key=\(locationIQApiKey)&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&limit=5&dedupe=1"
        
        guard let locationUrl = URL(string: locationUrlString) else { return }
        
        // Buat URLRequest dengan header Accept-Encoding
        var locationRequest = URLRequest(url: locationUrl)
        locationRequest.setValue("gzip, deflate", forHTTPHeaderField: "Accept-Encoding")
        
        URLSession.shared.dataTaskPublisher(for: locationRequest)
            .map { $0.data }
            .flatMap { [weak self] data -> AnyPublisher<Data, URLError> in
                do {
                    let decoder = JSONDecoder()
                    let cities = try decoder.decode([RealTimeSearchResponseLocation].self, from: data)
                    
                    DispatchQueue.main.async {
                        self?.results = cities
                        self?.multipleLocation = cities.map { $0.latAndLon }
                        self?.multipleWeatherLocation = self?.multipleLocation.joined(separator: "%7C") ?? ""
                    }
                    
                    guard let multipleWeatherLocation = self?.multipleWeatherLocation, !multipleWeatherLocation.isEmpty else {
                        throw URLError(.badURL)
                    }
                    
                    let weatherUrlString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timelinemulti?key=\(String(describing: self?.visualCrossingApiKey))&locations=\(multipleWeatherLocation)"
                    
                    guard let weatherUrl = URL(string: weatherUrlString) else {
                        throw URLError(.badURL)
                    }
                    
                    // Buat URLRequest dengan header Accept-Encoding untuk request weather
                    var weatherRequest = URLRequest(url: weatherUrl)
                    weatherRequest.setValue("gzip, deflate", forHTTPHeaderField: "Accept-Encoding")
                    
                    return URLSession.shared.dataTaskPublisher(for: weatherRequest)
                        .map { $0.data }
                        .eraseToAnyPublisher()
                    
                } catch {
                    return Fail(error: URLError(.cannotDecodeRawData))
                        .eraseToAnyPublisher()
                }
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Request failed with error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weatherData in
                do {
                    let decoder = JSONDecoder()
                    let weather = try decoder.decode(RealTimeWeatherResponseMultiple.self, from: weatherData)
                    DispatchQueue.main.async {
                        self?.weatherResults = [weather]
                    }
                } catch {
                    print("Failed to decode JSON with error: \(error)")
                }
            })
            .store(in: &cancellables)
    }
    
    func getMultipleWeather() {
        guard !multipleWeatherLocation.isEmpty else {
            print("multipleWeatherLocation is empty")
            return
        }
        
        let urlSession = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timelinemulti?key=\(visualCrossingApiKey)&locations=\(multipleWeatherLocation)"
        
        print(urlSession)
        
        guard let url = URL(string: urlSession) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Request failed with error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                do {
                    let decoder = JSONDecoder()
                    var weather = try decoder.decode(RealTimeWeatherResponseMultiple.self, from: data) // Decode as dictionary
                    
                    for i in 0..<weather.locations.count {
                        if i < self?.multipleLocationCitiesNames.count ?? 0 {
                            weather.locations[i].address = self?.multipleLocationCitiesNames[i] ?? "Unknown Location"
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self?.weatherResults = [weather] // Update sesuai dengan struktur data
                    }
                } catch {
                    print("Failed to decode JSON with error: \(error)")
                }
            })
            .store(in: &cancellables)
    }
}

// Part to get location name in realtime with LocationIQ
struct RealTimeSearchResponseLocation: Decodable, Identifiable {
    var address: Address
    var display_name: String
    var lat: String
    var lon: String
    
    var detailAddress: String {
        return "\(display_name)"
    }
    
    var latAndLon: String {
        return "\(lat)%2C\(lon)"
    }
    
    struct Address: Decodable {
        var name: String
        var country: String
    }
    
    var id: String {
        return UUID().uuidString
    }
}

struct RealTimeWeatherResponseMultiple: Decodable {
    var locations: [Location]
    
    struct Location: Decodable {
        var address: String
        var days: [Day]
        
        struct Day: Decodable {
            var temp: Double
            var conditions: String
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            address = try container.decode(String.self, forKey: .address)
            
            let allDays = try container.decode([Day].self, forKey: .days)
            days = Array(allDays.prefix(1))
        }
        
        private enum CodingKeys: String, CodingKey {
            case address
            case days
        }
    }
}
