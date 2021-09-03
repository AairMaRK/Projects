//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Egor Gryadunov on 31.08.2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var retryIncorrectCards: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(footer: Text("Cards for which you did not know the answer will go back to the end of the stack")) {
                    Toggle(isOn: $retryIncorrectCards) {
                        Text("Retry incorrect cards")
                    }
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
    }

    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(retryIncorrectCards: Binding.constant(false))
    }
}
