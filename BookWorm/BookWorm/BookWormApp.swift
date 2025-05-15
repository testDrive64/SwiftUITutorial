//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Norman on 24.03.25.
//

import SwiftUI
import SwiftData

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
