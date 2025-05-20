//
//  ContentView.swift
//  HotProspects
//
//  Created by Norman on 17.05.25.
//

import SwiftUI

struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    
    @State private var selection = Set<String>()
    @State private var selectedTab = "One"
    @State private var output = ""
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello, SwiftUI!")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                        backgroundColor = .red
                    }
                    
                    Button("Green") {
                        backgroundColor = .green
                    }
                    
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
        
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        if selection.isEmpty == false {
            Text("You selected \(selection.formatted())")
        }
        Image(.p1Front)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .background(.black)
        
        EditButton()
        
        Button("Show Tab 2") {
            selectedTab = "Two"
        }
        .tabItem{
            Label("One", systemImage: "star")
        }
        
        Text(output)
            .task {
                await fetchReadings()
            }
        
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .tabItem {
                    Label("One", systemImage: "star")
                }
                .tag("One")
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
    
    func fetchReadings() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        
        switch result {
            case .success(let str):
                output = str
            case .failure(let error):
                output = "Error \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
