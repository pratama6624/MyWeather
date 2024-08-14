//
//  HourlyForecastView.swift
//  MyWeather
//
//  Created by Pratama One on 11/08/24.
//

import SwiftUI

struct HourlyForecastView: View {
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
                
                Text("May 20, 2024")
                    .font(.callout)
            }
            .padding(.bottom, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    HStack {
                        HStack {
                            Image("CloudIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                        }
                        VStack(alignment: .leading) {
                            Text("15.00")
                            Text("32\u{00B0}")
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    HStack {
                        HStack {
                            Image("CloudIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                        }
                        VStack(alignment: .leading) {
                            Text("16.00")
                            Text("32\u{00B0}")
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(10)
                    
                    HStack {
                        HStack {
                            Image("CloudIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                        }
                        VStack(alignment: .leading) {
                            Text("14.00")
                            Text("32\u{00B0}")
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(10)
                }
            }
            .padding(.bottom, 30)
            
            HStack {
                Text("Next forecast")
                    .font(.title2)
                
                Spacer()
            }
            .padding(.bottom, 20)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Friday")
                            Text("May, 20")
                        }
                        
                        Spacer()
                        
                        Text("32\u{00B0}C")
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
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Saturday")
                            Text("May, 21")
                        }
                        
                        Spacer()
                        
                        Text("29\u{00B0}C")
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
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Sunday")
                            Text("May, 22")
                        }
                        
                        Spacer()
                        
                        Text("22\u{00B0}C")
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
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Monday")
                            Text("May, 23")
                        }
                        
                        Spacer()
                        
                        Text("24\u{00B0}C")
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
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Tuesday")
                            Text("May, 24")
                        }
                        
                        Spacer()
                        
                        Text("22\u{00B0}C")
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
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Wednesday")
                            Text("May, 25")
                        }
                        
                        Spacer()
                        
                        Text("20\u{00B0}C")
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
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Thursday")
                            Text("May, 26")
                        }
                        
                        Spacer()
                        
                        Text("28\u{00B0}C")
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
            
            Spacer()
        }
        .foregroundStyle(Color.white)
        .padding(.vertical, 90)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HourlyForecastView()
}
