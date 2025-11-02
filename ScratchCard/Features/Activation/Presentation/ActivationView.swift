//
//  ActivationView.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 02.11.2025.
//

import SwiftUI

struct ActivationView: View {
    var viewModel: ActivationViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Scratch Card Activation")
                .font(.title)
                .padding()

            switch viewModel.state {
            case .unscratched:
                VStack(spacing: 16) {
                    Text("Card must be scratched first")
                        .foregroundColor(.orange)
                }

            case .scratched:
                Button("Activate Card") {
                    Task {
                        await viewModel.activate()
                    }
                }
                .buttonStyle(.borderedProminent)

            case .activating:
                VStack(spacing: 16) {
                    ProgressView()
                    Text("Activating...")
                }

            case .activated:
                VStack(spacing: 16) {
                    Text("Activated Successfully!")
                        .font(.headline)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .task {
            await viewModel.onAppear()
        }
    }
}

