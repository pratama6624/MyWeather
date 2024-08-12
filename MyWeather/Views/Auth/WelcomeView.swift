//
//  WelcomeView.swift
//  MyWeather
//
//  Created by Pratama One on 11/08/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
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
                    
                    Button {
                        
                    } label: {
                        Text("Get start")
                            .font(.custom("Montserrat-SemiBold", size: 20))
                            .foregroundStyle(Color.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.yellow)
                            .cornerRadius(10)
                    }
                    
                }
                .foregroundColor(.white)
                .padding(.horizontal, 30)
            }
            .padding(.vertical, 50)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    WelcomeView()
}
