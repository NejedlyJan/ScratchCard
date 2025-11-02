//
//  ScratchFlow.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

import SwiftUI

struct ScratchFlow: View {
    struct Dependencies {
        let scratchView: (ScratchViewModel.Parameters) -> ScratchView
    }

    let dependencies: Dependencies

    @State private var isShowingError = false

    var body: some View {
        dependencies.scratchView(
            ScratchViewModel.Parameters(
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
