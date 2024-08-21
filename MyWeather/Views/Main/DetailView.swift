//
//  Detail.swift
//  MyWeather
//
//  Created by Pratama One on 19/08/24.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.title)
                .bold()
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height - 100)
        .background(Color.blue)
    }
}

#Preview {
    DetailView()
}
