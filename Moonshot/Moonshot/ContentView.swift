//
//  ContentView.swift
//  Moonshot
//
//  Created by Norman on 06.03.25.
//

import SwiftUI


struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State var showingGridLayout: Bool = true
    
    var body: some View {
        NavigationStack {
            Group {
                if showingGridLayout {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            showingGridLayout = false
                        } label: {
                            Image(systemName: "list.bullet")
                        }
                        Button {
                            showingGridLayout = true
                        } label: {
                            Image(systemName: "rectangle.grid.2x2")
                        }
                    }
                    
                }
            }
        }
        
    }
}


#Preview {
    ContentView()
}
