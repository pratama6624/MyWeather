//
//  LocationSearchView.swift
//  MyWeather
//
//  Created by Pratama One on 11/08/24.
//

import SwiftUI

struct LocationSearchView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Pick any location")
                    .font(.title2)
                    .bold()
                
                Text("You can add multiple locations to display as shortcuts on this page.")
                    .multilineTextAlignment(.center)
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
    LocationSearchView()
}
