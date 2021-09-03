//
//  HistoryView.swift
//  RoleIt
//
//  Created by Egor Gryadunov on 28.08.2021.
//

import SwiftUI

struct HistoryView: View
{
    @EnvironmentObject var rolls: Rolls
    
    var body: some View {
        List(rolls.all) { roll in
            Text("Roll: \(roll.value)")
                .foregroundColor(.secondary)
                .font(.headline)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
