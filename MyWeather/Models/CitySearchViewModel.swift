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
    @Published var results: [String] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $query
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] (query) in
                self?.searchCity(query: query)
            }
            .store(in: &cancellables)
    }
    
    private func searchCity(query: String) {
        guard query.count >= 3 else {
            results = []
            return
        }
        
        let allCities = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose"]
        if query.isEmpty {
            results = []
        } else {
            results = allCities.filter { $0.lowercased().contains(query.lowercased()) }
        }
    }
}

