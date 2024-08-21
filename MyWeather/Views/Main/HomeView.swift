//
//  HomeView.swift
//  MyWeather
//
//  Created by Pratama One on 11/08/24.
//

import SwiftUI

struct HomeView: View {
    var weather: ResponseBody
    @ObservedObject var viewModel = WeatherManager()
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text(viewModel.city)
                    .font(.title2)
                    .bold()
                    .onAppear {
                        Task {
                            await viewModel.loadCityName(latitude: viewModel.latitude, longitude: viewModel.longitude)
                        }
                    }
                
                Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                    .font(.callout)
                    .padding(.bottom, 10)
            }
            
            Spacer()
            
            Image("cloudrainy")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width / 2.5)
            
            Spacer()
            
            HStack {
                Text("\(weather.currentConditions.temp.toCelciul().roundDouble())\u{00B0}C")
                    .font(.system(size: 50))
                    .bold()
            }
            
            Spacer()
            
            Spacer()
            
            HStack {
                VStack {
                    Text("Feels")
                    Text("\(weather.currentConditions.feelslike.toCelciul().roundDouble())\u{00B0}C")
                }
                .font(.headline)
                .frame(width: UIScreen.main.bounds.width / 4)
                
                VStack {
                    Text("Wind")
                    Text("\(weather.currentConditions.windspeed.roundDouble())m/s")
                }
                .font(.headline)
                .frame(width: UIScreen.main.bounds.width / 4)
                
                VStack {
                    Text("Humidity")
                    Text("\(weather.currentConditions.humidity.roundDouble())%")
                }
                .font(.headline)
                .frame(width: UIScreen.main.bounds.width / 4)
            }
            
            Spacer()
            
            Spacer()
            
            HStack {
                Text("Today")
                    .font(.headline)
                
                Spacer()
                
                Text("View full report")
                    .font(.callout)
                    .foregroundStyle(Color.blue)
            }
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        if let firstDay = weather.days.first {
                            ForEach(firstDay.hours, id: \.datetimeEpoch) { hour in
                                Button {
                                    // Do something here
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text(TimeExtension().convertEpochToHour(epoch: hour.datetimeEpoch))
                                                    .bold()
                                                
                                                Spacer()
                                            }
                                            
                                            HStack(spacing: 20) {
                                                Image("CloudIcon")                             .resizable()                                  .scaledToFit()                                    .frame(width: 60)
                                                
                                                VStack(alignment: .leading, spacing: 5) {
                                                    HStack {
                                                        Text("\(hour.temp.toCelciul().roundDouble())\u{00B0}C")
                                                            .font(.title3)
                                                            .bold()
                                                    }
                                                    HStack {
                                                        Text("\(hour.uvindex) UV")
                                                            .font(.callout)
                                                            .padding(.trailing, 10)
                                                        
                                                        Image(systemName: "arrow.up")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(height: 12)
                                                        Text("\(hour.feelslike.toCelciul().roundDouble())\u{00B0}C")
                                                            .font(.callout)
                                                            .padding(.trailing, 10)
                                                        
                                                        Image(systemName: "drop.fill")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(height: 12)
                                                        Text("\(hour.humidity.roundDouble())%")
                                                    }
                                                }
                                            }                                        }
                                    }
                                    .frame(width: UIScreen.main.bounds.width - 82)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 10)
                                    .background(hour.datetimeEpoch <= WeatherScrollHelper.currentEpochTime ? Color.blue.opacity(0.3) : Color.blue.opacity(0.7))
                                    .cornerRadius(15)
                                    .id(hour.datetimeEpoch)
                                }
                                .containerRelativeFrame(.horizontal, count: 1, spacing: 15)
                                .scrollTransition { content, phase in
                                    content.opacity(phase.isIdentity ? 1.0 : 0.1)
                                        .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3, y: phase.isIdentity ? 1.0 : 0.3)
                                        .offset(y: phase.isIdentity ? 0 : 100)
                                }
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .onAppear {
                    WeatherScrollHelper.scrollToCurrentHour(proxy: proxy, weather: weather, currentEpochTime: WeatherScrollHelper.currentEpochTime)
                }
                .padding(.bottom, 30)
                .contentMargins(16, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
            }
        }
        .foregroundStyle(Color.white)
        .padding(.vertical, 70)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView(weather: previewWeather)
}
