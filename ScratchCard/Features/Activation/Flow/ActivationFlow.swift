//
//  ActivationFlow.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 02.11.2025.
//

import SwiftUI

struct ActivationFlow: View {
    struct Dependencies {
        let activationView: (ActivationViewModel.Parameters) -> ActivationView
    }

    let dependencies: Dependencies

    @State private var isShowingError = false

    var body: some View {
        dependencies.activationView(
            ActivationViewModel.Parameters(
                onAction: { onAction in
                    switch onAction {
                    case .error:
                        isShowingError = true
                    }
                }
            )
        )
        .sheet(isPresented: $isShowingError) {
            ErrorView {
                isShowingError = false
            }
        }
    }
}
