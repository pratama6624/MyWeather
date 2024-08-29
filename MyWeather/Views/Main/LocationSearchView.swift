//
//  LocationSearchView.swift
//  MyWeather
//
//  Created by Pratama One on 11/08/24.
//

import SwiftUI

struct LocationSearchView: View {
    var weather: ResponseBody
    @ObservedObject var viewModel = WeatherManager()
    @State private var showPopup: Bool = false
    @StateObject private var citySearchViewModel = CitySearchViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("Pick any location")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 30)
                    
                    Text("You can add multiple locations to display as shortcuts on this page.")
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ZStack {
                            Rectangle()
                                .foregroundStyle(Color.blue.opacity(0.5))
                                .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 140)
                                .cornerRadius(20)
                                .padding(.bottom, 10)
                            
                            VStack {
                                HStack {
                                    VStack(alignment:. leading, spacing: 10) {
                                        Text("\(weather.currentConditions.temp.toCelciul().roundDouble())\u{00B0}C")
                                        Text("Cloudy")
                                            .font(.callout)
                                    }
                                    
                                    Spacer()
                                    
                                    Image("cloudrainy")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50)
                                }
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text(viewModel.city)
                                        .font(.headline)
                                        .onAppear {
                                            Task {
                                                await viewModel.loadCityName(latitude: viewModel.latitude, longitude: viewModel.longitude)
                                            }
                                        }
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    
                        ForEach(0..<2) { i in
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(Color.blue.opacity(0.2))
                                    .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 140)
                                    .cornerRadius(20)
                                    .padding(.bottom, 10)
                                
                                VStack {
                                    HStack {
                                        VStack(alignment:. leading, spacing: 10) {
                                            Text("32\u{00B0}C")
                                            Text("Cloudy")
                                                .font(.callout)
                                        }
                                        
                                        Spacer()
                                        
                                        Image("cloudrainy")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50)
                                    }
                                    .padding(.bottom, 10)
                                    
                                    HStack {
                                        Text("California")
                                            .font(.headline)
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .foregroundStyle(Color.blue.opacity(0.5))
                                .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 140)
                                .cornerRadius(20)
                                .padding(.bottom, 10)
                            
                            VStack {
                                Button {
                                    withAnimation {
                                        showPopup = true
                                    }
                                } label: {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                        .padding(.bottom, 10)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
                
                Spacer()
            }
            .foregroundStyle(Color.white)
            .padding(.vertical, 70)
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Pop up
            if showPopup {
                Color.black.opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showPopup = false
                            citySearchViewModel.query = "Find city by name"
                        }
                    }
                
                VStack(spacing: 20) {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            
                            TextField("Search", text: $citySearchViewModel.query)
                                .onTapGesture {
                                    citySearchViewModel.query = ""
                                }
                            
                            Spacer()
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                    }
                    
                    VStack {
//                        if citySearchViewModel.query.count == 0 || citySearchViewModel.query == "Find city by name" {
//                            HStack {
//                                HStack {
//                                    Text(viewModel.city)
//                                        .font(.callout)
//                                        .bold()
//                                        .onAppear {
//                                            Task {
//                                                await viewModel.loadCityName(latitude: viewModel.latitude, longitude: viewModel.longitude)
//                                            }
//                                        }
//                                    
//                                    Spacer()
//                                    
//                                    Image(systemName: "checkmark")
//                                }
//                                .padding(10)
//                                .padding(.horizontal, 15)
//                                .frame(maxWidth: .infinity)
//                                .background(Color.blue.opacity(0.5))
//                                .cornerRadius(10)
//                            }
//                        }
                        
                        if citySearchViewModel.results.isEmpty {
                            VStack {
                                Spacer()
                                
                                HStack {
                                    Image(systemName: "sparkle.magnifyingglass")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100)
                                }
                                .opacity(0.4)
                                
                                Spacer()
                            }
                            .frame(height: UIScreen.main.bounds.height / 2)
                        } else {
                            withAnimation {
                                ScrollView(.vertical, showsIndicators: false) {
                                    LazyVGrid(columns: columns) {
                                        ForEach(citySearchViewModel.results) { city in
                                            ZStack {
                                                Rectangle()
                                                    .foregroundStyle(Color.blue.opacity(0.5))
                                                    .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 140)
                                                    .cornerRadius(20)
                                                    .padding(.bottom, 10)
                                                
                                                VStack {
                                                    HStack {
                                                        VStack(alignment:. leading, spacing: 10) {
                                                            Text("\(weather.currentConditions.temp.toCelciul().roundDouble())\u{00B0}C")
                                                            Text("Cloudy")
                                                                .font(.callout)
                                                        }
                                                        
                                                        Spacer()
                                                        
                                                        Image("cloudrainy")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 50)
                                                    }
                                                    .padding(.bottom, 10)
                                                    
                                                    HStack {
                                                        Text(viewModel.city)
                                                            .font(.headline)
                                                            .onAppear {
                                                                Task {
                                                                    await viewModel.loadCityName(latitude: viewModel.latitude, longitude: viewModel.longitude)
                                                                }
                                                            }
                                                        Spacer()
                                                    }
                                                }
                                                .padding(.horizontal, 20)
                                            }
                                        }
                                    }
                                }
                                .frame(height: UIScreen.main.bounds.height / 2)
                            }
                        }
                    }
                    .foregroundStyle(Color.white)
                }
                .padding()
                .background(Color("Brand"))
                .cornerRadius(10)
                .shadow(radius: 20)
                .frame(width: UIScreen.main.bounds.width - 40)
            }
        }
    }
}

#Preview {
    LocationSearchView(weather: previewWeather)
}
