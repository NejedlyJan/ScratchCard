//
//  ErrorView.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 02.11.2025.
//

import SwiftUI

struct ErrorView: View {
    let onFinish: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Something went wrong")
                .font(.title)
                .foregroundColor(.primary)
            
            Button("OK") {
                onFinish()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
