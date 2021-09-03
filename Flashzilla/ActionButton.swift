//
//  ActionButton.swift
//  Flashzilla
//
//  Created by Egor Gryadunov on 31.08.2021.
//

import SwiftUI

struct ActionButton: View
{
    let systemImage: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
        }
        .foregroundColor(.white)
        .font(.largeTitle)
    }
}
