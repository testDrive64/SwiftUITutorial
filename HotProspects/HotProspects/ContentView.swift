//
//  ContentView.swift
//  HotProspects
//
//  Created by Norman on 17.05.25.
//

import SwiftUI
import UserNotifications
import SamplePackage

struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    let possibleNumbers = 1...60
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
    @State private var selection = Set<String>()
    @State private var selectedTab = "One"
    @State private var output = ""
    @State private var backgroundColor = Color.red
    
    var body: some View {
        
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
            
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
        .modelContainer(for: Prospect.self)
}
