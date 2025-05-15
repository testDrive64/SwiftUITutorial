//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Norman on 20.03.25.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.user.name)
                TextField("Street Address", text: $order.user.streetAddress)
                TextField("City", text: $order.user.city)
                TextField("Zip", text: $order.user.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
