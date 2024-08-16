//
//  ContentView.swift
//  MyWeather
//
//  Created by Pratama One on 10/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
//                    // Just for test
//                    Button {
//                        x(weather: weather)
//                    } label: {
//                        Text("Just Test")
//                    }
                    TabView(weather: weather)
                } else {
                    ProgressView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print(("Error getting weather: \(error)"))
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    ProgressView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
    }
    
    private func x(weather: ResponseBody?) {
        print(weather!)
    }
}

#Preview {
    ContentView()
}
