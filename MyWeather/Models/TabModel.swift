//
//  TabModel.swift
//  MyWeather
//
//  Created by Pratama One on 11/08/24.
//

import Foundation
import SwiftUI

enum TabType: String, Codable {
    case home = "Home"
    case locationSearch = "LocationSearch"
    case hourlyForecast = "HourlyForecast"
    case setting = "Setting"
}

class TabModel: ObservableObject {
    @Published var selectedTab: TabType = .home
    
    func contentViewForTab() -> AnyView {
        
        @ViewBuilder
        var view: some View {
            switch selectedTab {
            case .home:
                HomeView(weather: previewWeather)
            case .locationSearch:
                LocationSearchView(weather: previewWeather)
            case .hourlyForecast:
                HourlyForecastView(weather: previewWeather)
            case .setting:
                SettingView()
            }
        }
        
        return AnyView(view)
    }
}
