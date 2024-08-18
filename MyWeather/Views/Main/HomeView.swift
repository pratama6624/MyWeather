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
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("Forecast")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    Button {
                        
                    } label: {
                        Text("Air Quality")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(10)
                }
            }
            
            Spacer()
            
            Image("cloudrainy")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width / 2)
            
            Spacer()
            
            HStack {
                VStack {
                    Text("Temp")
                    Text("\(weather.currentConditions.temp.toCelciul().roundDouble())\u{00B0}C")
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
                    .font(.title2)
                
                Spacer()
                
                Text("View full report")
                    .font(.title3)
                    .foregroundStyle(Color.blue)
            }
            .padding(.bottom, 20)
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        if let firstDay = weather.days.first {
                            ForEach(firstDay.hours, id: \.datetimeEpoch) { hour in
                                HStack {
                                    HStack {
                                        Image("CloudIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(TimeExtension().convertEpochToHour(epoch: hour.datetimeEpoch))
                                        Text("\(hour.temp.toCelciul().roundDouble())\u{00B0}C")
                                    }
                                }
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                                .background(hour.datetimeEpoch <= WeatherScrollHelper.currentEpochTime ? Color.blue.opacity(0.3) : Color.blue)
                                .cornerRadius(10)
                                .id(hour.datetimeEpoch)
                            }
                        }
                    }
                }
                .onAppear {
                    WeatherScrollHelper.scrollToCurrentHour(proxy: proxy, weather: weather, currentEpochTime: WeatherScrollHelper.currentEpochTime)
                }
                .padding(.bottom, 30)
            }
        }
        .foregroundStyle(Color.white)
        .padding(.vertical, 90)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView(weather: previewWeather)
}
