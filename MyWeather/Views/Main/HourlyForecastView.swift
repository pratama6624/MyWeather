//
//  HourlyForecastView.swift
//  MyWeather
//
//  Created by Pratama One on 11/08/24.
//

import SwiftUI

struct HourlyForecastView: View {
    var weather: ResponseBody
    @ObservedObject var viewModel = WeatherManager()
    
    var body: some View {
        VStack {
            VStack {
                Text("Forecast report")
                    .font(.title2)
                    .bold()
            }
            .padding(.bottom, 30)
            
            HStack {
                Text("Today")
                    .font(.title2)
                
                Spacer()
                
                Text("\(Date().formatted(.dateTime.month().day().hour().minute()))")
                    .font(.callout)
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
            
            HStack {
                Text("Next forecast")
                    .font(.title2)
                
                Spacer()
            }
            .padding(.bottom, 20)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    ForEach(weather.days.dropFirst(), id: \.datetimeEpoch) { day in
//
                        HStack {
                            VStack(alignment: .leading) {
                                Text(TimeExtension().convertEpochToDay(epoch: day.datetimeEpoch))
                                Text(TimeExtension().convertEpochToDayAndDate(epoch: day.datetimeEpoch))
                            }
                            
                            Spacer()
                            
                            Text("\(day.temp.toCelciul().roundDouble())\u{00B0}C")
                                .font(.title)
                                .bold()
                            
                            Spacer()
                            
                            Image("cloudrainy")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                        }
                        .padding(20)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                }
            }
            
            Spacer()
        }
        .foregroundStyle(Color.white)
        .padding(.vertical, 90)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HourlyForecastView(weather: previewWeather)
}
