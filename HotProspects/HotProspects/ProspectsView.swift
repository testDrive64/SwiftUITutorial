//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Norman on 30.05.25.
//

import SwiftUI
import SwiftData

enum FilterType {
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext
    
    let filter: FilterType
    
    var title: String {
        switch filter {
            case .none:
                "Everyone"
            case .contacted:
                "Contaced people"
            case .uncontacted:
                "Uncontacted people"
        }
    }
    
    var body: some View {
        NavigationStack {
            Text("People: \(prospects.count)")
                .navigationTitle(title)
                .toolbar {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        let prospect = Prospect(name: "Paul Hudson", emailAddress: "paul@hackingwithswift.com", isContected: false)
                        modelContext.insert(prospect)
                    }
                }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
