//
//  HomeViews.swift
//  MyWeather
//
//  Created by Pratama One on 11/08/24.
//

import SwiftUI

struct TabView: View {
    @StateObject var tap = TabModel()
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("BackgroundWelcomeScreen")
                .resizable()
            
            VStack {
                tap.contentViewForTab()
            }
            
            HStack {
                Spacer()
                Button {
                    tap.selectedTab = .home
                } label: {
                    VStack {
                        Image(systemName: "house.fill")
                            .frame(width: 70)
                    }
                }
                
                Button {
                    tap.selectedTab = .locationSearch
                } label: {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .frame(width: 70)
                    }
                }
                
                Button {
                    tap.selectedTab = .hourlyForecast
                } label: {
                    VStack {
                        Image(systemName: "cloud.sun.bolt")
                            .frame(width: 70)
                    }
                }
                
                Button {
                    tap.selectedTab = .setting
                } label: {
                    VStack {
                        Image(systemName: "gearshape")
                            .frame(width: 70)
                    }
                }
                Spacer()
            }
            .padding(40)
            .foregroundColor(Color.white)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TabView()
}
