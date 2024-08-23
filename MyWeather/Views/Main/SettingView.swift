//
//  SettingView.swift
//  MyWeather
//
//  Created by Pratama One on 11/08/24.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var viewModel = WeatherManager()
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Setting")
                    .font(.title2)
                    .bold()
                
                Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                    .font(.callout)
                    .padding(.bottom, 10)
            }
            .padding(.bottom, 50)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Location")
                    Spacer()
                }
                
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Device location")
                        }
                        
                        Spacer()
                        
                        Text(viewModel.city)
                            .font(.callout)
                            .bold()
                            .onAppear {
                                Task {
                                    await viewModel.loadCityName(latitude: viewModel.latitude, longitude: viewModel.longitude)
                                }
                            }
                    }
                    .padding()
                    .frame(height: 50)
                    .background(Color.blue.opacity(0.5))
                    .cornerRadius(10)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Default")
                        }
                        
                        Spacer()
                        
//                        Text("City name")
//                            .font(.callout)
//                            .bold()
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .bold()
                        }
                    }
                    .padding()
                    .frame(height: 50)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                }
            }
            .font(.callout)
            .padding(.bottom, 20)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Temperature Units")
                    Spacer()
                }
                
                HStack {
                    Button {
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Celcius")
                            }
                            
                            Spacer()
                            
                            Text("\u{00B0}C")
                                .font(.title3)
                                .bold()
                        }
                        .padding()
                        .frame(height: 50)
                        .background(Color.blue.opacity(0.5))
                        .cornerRadius(10)
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Fahrenheit")
                            }
                            
                            Spacer()
                            
                            Text("\u{00B0}F")
                                .font(.title3)
                                .bold()
                        }
                        .padding()
                        .frame(height: 50)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
            }
            .font(.callout)
            .padding(.bottom, 20)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Wind Speed ​​Unit")
                    Spacer()
                }
                
                HStack {
                    Button {
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Kilometers")
                            }
                            
                            Spacer()
                            
                            Text("km/h")
                                .font(.callout)
                                .bold()
                        }
                        .padding()
                        .frame(height: 50)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Meters")
                            }
                            
                            Spacer()
                            
                            Text("mph")
                                .font(.callout)
                                .bold()
                        }
                        .padding()
                        .frame(height: 50)
                        .background(Color.blue.opacity(0.5))
                        .cornerRadius(10)
                    }
                }
            }
            .font(.callout)
            .padding(.bottom, 20)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Language")
                    Spacer()
                }
                
                HStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("English")
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .bold()
                        }
                    }
                    .padding()
                    .frame(height: 50)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                }
            }
            .font(.callout)
            .padding(.bottom, 20)
            
            Spacer()
        }
        .foregroundStyle(Color.white)
        .padding(.vertical, 70)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SettingView()
}
