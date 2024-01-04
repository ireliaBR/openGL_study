//
//  ContentView.swift
//  SwiftUI_Triangle
//
//  Created by fdd on 2024/1/4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TriangleView().frame(height: 300)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
