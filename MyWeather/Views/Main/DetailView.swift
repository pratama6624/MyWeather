//
//  Detail.swift
//  MyWeather
//
//  Created by Pratama One on 19/08/24.
//

import SwiftUI

struct DetailView: View {
    var weather: ResponseBody.Day
    @ObservedObject var viewModel = WeatherManager()
    
    var body: some View {
        ZStack {
            Image("BackgroundWelcomeScreen")
                .resizable()
            
            VStack {
                VStack {
                    Text("\(TimeExtension().convertEpochToDayAndDate(epoch: weather.datetimeEpoch)) \(TimeExtension().convertEpochToDay(epoch: weather.datetimeEpoch))")
                        .font(.title3)
                        .bold()
                }
                
                Spacer()
                    
                VStack {
                    Text("\(weather.temp.toCelciul().roundDouble())\u{00B0}C")
                        .font(.system(size: 50))
                        .bold()
                    
                    Text(weather.conditions)
                }
                
                Spacer()
                
                HStack {
                    VStack {
                        Text("Feels")
                        Text("\(weather.feelslike.toCelciul().roundDouble())\u{00B0}C")
                    }
                    .font(.headline)
                    .frame(width: UIScreen.main.bounds.width / 4)
                    
                    VStack {
                        Text("Wind")
                        Text("\(weather.windspeed.roundDouble())m/s")
                    }
                    .font(.headline)
                    .frame(width: UIScreen.main.bounds.width / 4)
                    
                    VStack {
                        Text("Humidity")
                        Text("\(weather.humidity.roundDouble())%")
                    }
                    .font(.headline)
                    .frame(width: UIScreen.main.bounds.width / 4)
                }
                
                Spacer()
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(weather.hours, id: \.datetimeEpoch) { hour in
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
                                            }
                                            .padding(.bottom, 20)
                                            
                                            VStack(spacing: 10) {
                                                HStack {
                                                    Text("Wind speed")
                                                    Spacer()
                                                    Text("\(weather.windspeed.roundDouble())m/s")
                                                }
                                                .font(.callout)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 20)
                                    .frame(width: UIScreen.main.bounds.width - 82)
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
                        .scrollTargetLayout()
                    }
                    .onAppear {
                        WeatherScrollHelper.scrollToCurrentHour(proxy: proxy, weather: weather, currentEpochTime: WeatherScrollHelper.currentEpochTime)
                    }
                    .contentMargins(16, for: .scrollContent)
                    .scrollTargetBehavior(.viewAligned)
                }
            }
            .foregroundStyle(Color.white)
            .padding(.vertical, 40)
            .padding(.horizontal, 30)
        }
        .ignoresSafeArea()
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    DetailView(weather: ResponseBody.Day.mock)
}
