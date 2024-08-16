//
//  WelcomeView.swift
//  MyWeather
//
//  Created by Pratama One on 11/08/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("BackgroundWelcomeScreen")
                    .resizable()
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image("CloudIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 2)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("Weather")
                                .font(.custom("Montserrat-SemiBold", size: 30))
                                .font(.title)
                                .bold()
                            Text("News")
                                .font(.custom("Montserrat-SemiBold", size: 30))
                                .font(.title)
                                .bold()
                                .foregroundStyle(Color.yellow)
                        }
                        
                        HStack {
                            Text("&")
                                .font(.custom("Montserrat-SemiBold", size: 30))
                                .font(.title)
                                .bold()
                                .foregroundStyle(Color.yellow)
                            Text("Feed")
                                .font(.custom("Montserrat-SemiBold", size: 30))
                                .font(.title)
                                .bold()
                                .foregroundStyle(Color.yellow)
                        }
                        
                        Text("We are here to help you plan your day better. Get the latest, accurate and reliable weather information right in the palm of your hand.")
                            .font(.callout)
                            .lineSpacing(10)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 30)
                            .padding(.horizontal, 25)
                        
//                        NavigationLink(destination: TabView()) {
//                            Text("Get start")
//                                .font(.custom("Montserrat-SemiBold", size: 20))
//                                .foregroundStyle(Color.black)
//                                .frame(maxWidth: .infinity)
//                                .padding(.vertical, 18)
//                                .background(Color.yellow)
//                                .cornerRadius(10)
//                        }
                        
                        LocationButton(.shareCurrentLocation) {
                            locationManager.requestLocation()
                        }
                        .cornerRadius(30)
                        .symbolVariant(.fill)
                        .foregroundStyle(Color.white)
                        
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    
                    Spacer()
                }
                .padding(.vertical, 50)
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    WelcomeView()
}
