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
    
    
    var body: some View {
        
        
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        if selection.isEmpty == false {
            Text("You selected \(selection.formatted())")
        }
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
