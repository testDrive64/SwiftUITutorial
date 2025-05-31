//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Norman on 17.05.25.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
