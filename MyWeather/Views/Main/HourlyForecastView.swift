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
    @State private var selectedDay: ResponseBody.Day?
    
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
                .padding(.bottom, 20)
                .contentMargins(16, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
            }
            
            HStack {
                Text("Next forecast")
                    .font(.title2)
                
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    ForEach(weather.days.dropFirst(), id: \.datetimeEpoch) { day in

                        Button {
                            selectedDay = day
                            print(selectedDay?.datetime)
                        } label: {
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
                            .id(day.datetimeEpoch)
                        }
                    }
                    
                }
            }
            .onAppear {
                print("ContentView appeared") // Debugging log
            }
            
            Spacer()
        }
        .popover(item: $selectedDay) { day in
            DetailView()
        }
        .foregroundStyle(Color.white)
        .padding(.vertical, 70)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HourlyForecastView(weather: previewWeather)
}
