//
//  ContentView.swift
//  Instafilter
//
//  Created by Norman on 05.04.25.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("Hello, world!") {
                showingConfirmation = true
            }
            .frame(width: 300, height: 300)
            .background(backgroundColor)
                .blur(radius: blurAmount)
                .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                    Button("Red") { backgroundColor = .red}
                    Button("Green") { backgroundColor = .green }
                    Button("Blue") { backgroundColor = .blue }
                    Button("Yellow") { backgroundColor = .yellow }
                    Button("Orange") { backgroundColor = .orange }
                    Button("White") { backgroundColor = .white }
                    Button("Black") { backgroundColor = .black }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Select a new color")
                }
            
            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { oldValue, newValue in
                    print("New value is \(newValue)")
                }
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
