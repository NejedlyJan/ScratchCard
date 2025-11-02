//
//  DashboardView.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 02.11.2025.
//

import SwiftUI

struct DashboardView: View {
    var viewModel: DashboardViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Scratch Card Dashboard")
                .font(.title)
                .padding()

            switch viewModel.state {
            case .loading:
                ProgressView()

            case .loaded(let card):
                VStack(spacing: 16) {
                    Text("Current State:")
                        .font(.headline)

                    Text(stateText(for: card.state))
                        .font(.title2)
                        .padding()

                    Button("Scratch") {
                        viewModel.onScratch()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Activate") {
                        viewModel.onActivate()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .padding()
        .task {
            await viewModel.onAppear()
        }
    }

    private func stateText(for state: ScratchCard.ScratchCardState) -> String {
        switch state {
        case .unscratched:
            return "Unscratched"
        case .scratched(let code):
            return "Scratched - Code: \(code)"
        case .activated:
            return "Activated"
        }
    }
}
