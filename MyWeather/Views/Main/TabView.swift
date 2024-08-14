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
                        Image(systemName: tap.selectedTab == .home ? "house.fill" : "house")
                            .frame(width: 70)
                    }
                }
                
                Button {
                    tap.selectedTab = .locationSearch
                } label: {
                    VStack {
                        Image(systemName: tap.selectedTab == .locationSearch ? "sparkle.magnifyingglass" : "magnifyingglass")
                            .frame(width: 70)
                    }
                }
                
                Button {
                    tap.selectedTab = .hourlyForecast
                } label: {
                    VStack {
                        Image(systemName: tap.selectedTab == .hourlyForecast ? "cloud.sun.bolt.fill" : "cloud.sun.bolt")
                            .frame(width: 70)
                    }
                }
                
                Button {
                    tap.selectedTab = .setting
                } label: {
                    VStack {
                        Image(systemName: tap.selectedTab == .setting ? "gearshape.fill" : "gearshape")
                            .frame(width: 70)
                    }
                }
                Spacer()
            }
            .padding(40)
            .foregroundColor(Color.white)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabView()
}
