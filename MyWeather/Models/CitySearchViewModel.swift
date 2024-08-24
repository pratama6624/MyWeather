//
//  CitySearchViewModel.swift
//  MyWeather
//
//  Created by Pratama One on 24/08/24.
//

import SwiftUI
import Combine

class CitySearchViewModel: ObservableObject {
    @Published var query: String = "Find city by name"
    @Published var results: [City] = []
    private var cancellables = Set<AnyCancellable>()
    private var locationIQApiKey: String = "pk.dbe30b0178fa9e2c3d68e1e4c8269ab4"
    
    init() {
        $query
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] (query) in
                self?.searchForCity()
            }
            .store(in: &cancellables)
    }
//    
//    private func searchCity(query: String) {
//        guard query.count >= 3 else {
//            results = []
//            return
//        }
//        
//        let allCities = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose"]
//        if query.isEmpty {
//            results = []
//        } else {
//            results = allCities.filter { $0.lowercased().contains(query.lowercased()) }
//        }
//    }
    
    func searchForCity() {
        guard query.count >= 3, query != "Find city by name" else {
            results = []
            return
        }
        
        print("Query = \(query)\n")
        
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
                    let cities = try decoder.decode([City].self, from: data)
                    DispatchQueue.main.async {
                        self?.results = cities
                    }
                } catch {
                    print("Failed to decode JSON with error: \(error)")
                }
            })
            .store(in: &cancellables)
        
        print(results)
    }
    
}

struct City: Decodable, Identifiable {
    let display_name: String
    let lat: String
    let lon: String
    
    var shortName: String {
        let components = display_name.split(separator: ",")
        return components.first?.trimmingCharacters(in: .whitespaces) ?? ""
    }
    
    var id: String {
        return "\(display_name)-\(lat)-\(lon)"
    }
}
