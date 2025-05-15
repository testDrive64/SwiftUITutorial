//
//  ContentView.swift
//  BucketList
//
//  Created by Norman on 28.04.25.
//

import MapKit
import LocalAuthentication
import SwiftUI

struct User: Comparable, Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
#if DEBUG
static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs", latitude: 51.501, longitude: -0.141)
#endif
}

struct ContentView: View {
    enum LoadingStates {
        case loading, success, failed
    }
    
    @State private var viewModel = ViewModel()
    
    @State private var isUnlocked = false
    @State private var loadingState = LoadingStates.failed
    
    @State private var startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    @State private var mapMode = MapStyle.standard
    
    var body: some View {
        //if viewModel.isUnlocked {
        ZStack(alignment: .topLeading) {

            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .simultaneousGesture(
                                    LongPressGesture().onEnded { _ in
                                        viewModel.selectedPlace = location
                                    }
                                )
                        }
                    }
                }
                .mapStyle(mapMode)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) {
                        viewModel.update(location: $0)
                    }
                }
            }
            VStack(spacing: 10) {
                Button(action: {
                    mapMode = MapStyle.standard
                }) {
                    Text("Standard")
                    Image(systemName: "map")
                    
                }
                Button(action: {
                    mapMode = MapStyle.hybrid
                }) {
                    Text("Hybrid")
                   Image(systemName: "map.fill")
                }
            }
            .padding()
            
        }
            
//        } else {
//            Button("Unlock Places", action: viewModel.authenticate)
//                .padding()
//                .background(.blue)
//                .foregroundStyle(.white)
//                .clipShape(.capsule)
//        }
        .alert(isPresented: $viewModel.alert) {
            Alert(title: Text(viewModel.alertTitle))
        }
    }
    
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    // authentication successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
    
}

#Preview {
    ContentView()
}
