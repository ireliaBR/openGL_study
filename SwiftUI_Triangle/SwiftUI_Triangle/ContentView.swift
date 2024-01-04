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
            CameraCircleView().frame(height: 300)
        }
        .padding()
        .task {
            test()
        }
    }
    
    func test() {
//        if let bundlePath = Bundle.main.bundlePath {
            print("Bundle Path: \(Bundle.main.bundlePath)")
//        } else {
//            print("Unable to retrieve bundle path.")
//        }
    }
}

#Preview {
    ContentView()
}
