//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Egor Gryadunov on 02.08.2021.
//

import SwiftUI

struct AddressView: View
{
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.info.name)
                TextField("Street address", text: $order.info.streetAddress)
                TextField("City", text: $order.info.city)
                TextField("Zip", text: $order.info.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.info.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
