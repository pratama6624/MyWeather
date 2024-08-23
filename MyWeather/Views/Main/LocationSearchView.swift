//
//  LocationSearchView.swift
//  MyWeather
//
//  Created by Pratama One on 11/08/24.
//

import SwiftUI

struct LocationSearchView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            VStack {
                Text("Pick any location")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 30)
                
                Text("You can add multiple locations to display as shortcuts on this page.")
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom, 30)
            
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                    
                    Spacer()
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                
                Image(systemName: "location.north")
                    .padding(20)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding(.bottom, 30)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(0..<4) { i in
                        ZStack {
                            Rectangle()
                                .foregroundStyle(Color.blue.opacity(0.5))
                                .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 140)
                                .cornerRadius(20)
                                .padding(.bottom, 10)
                            
                            VStack {
                                HStack {
                                    VStack(alignment:. leading, spacing: 10) {
                                        Text("32\u{00B0}C")
                                        Text("Cloudy")
                                            .font(.callout)
                                    }
                                    
                                    Spacer()
                                    
                                    Image("cloudrainy")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50)
                                }
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("California")
                                        .font(.headline)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    ZStack {
                        Rectangle()
                            .foregroundStyle(Color.blue.opacity(0.5))
                            .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 140)
                            .cornerRadius(20)
                            .padding(.bottom, 10)
                        
                        VStack {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .padding(.bottom, 10)
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            
            Spacer()
        }
        .foregroundStyle(Color.white)
        .padding(.vertical, 70)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LocationSearchView()
}
