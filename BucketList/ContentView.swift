//
//  ContentView.swift
//  BucketList
//
//  Created by Egor Gryadunov on 15.08.2021.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View
{
    @State private var isUnlocked = false
    @State private var showingAuthenticationAlert = false
    @State private var authenticationError = ""
    
    var body: some View {
        ZStack {
            if isUnlocked {
                UnlockedView()
            } else {
                Button("Unlock places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $showingAuthenticationAlert) {
            Alert(title: Text("Authentication error"), message: Text(self.authenticationError), dismissButton: .default(Text("OK")))
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        self.authenticationError = "\(authenticationError?.localizedDescription ?? "Unknown error.")"
                        self.showingAuthenticationAlert = true
                    }
                }
            }
        } else {
            self.authenticationError = "Biometrics authentication unavailable."
            self.showingAuthenticationAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
