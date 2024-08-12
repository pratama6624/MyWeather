//
//  HomeView.swift
//  MyWeather
//
//  Created by Pratama One on 11/08/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("San Fransisco")
                    .font(.title2)
                    .bold()
                
                Text("May 20, 2024")
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
                    Text("32\u{00B0}")
                }
                .font(.headline)
                .frame(width: UIScreen.main.bounds.width / 4)
                
                VStack {
                    Text("Wind")
                    Text("10Km/h")
                }
                .font(.headline)
                .frame(width: UIScreen.main.bounds.width / 4)
                
                VStack {
                    Text("Humidity")
                    Text("75%")
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
            
            Spacer()
        }
        .foregroundStyle(Color.white)
        .padding(.vertical, 100)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView()
}
